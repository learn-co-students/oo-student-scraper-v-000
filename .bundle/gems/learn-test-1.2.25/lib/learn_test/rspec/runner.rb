module LearnTest
  module RSpec
    class Runner
      attr_accessor :parsed_output, :json_output, :formatted_results, :keep_results
      attr_reader :username, :user_id, :repo_name, :options, :connection

      def initialize(username, user_id, repo_name, options)
        @username = username
        @user_id = user_id
        @repo_name = repo_name
        @options = options
        @json_output = ""
        @parsed_output = nil
        @formatted_results = {}
        @connection = Faraday.new(url: SERVICE_URL) do |faraday|
          faraday.adapter  Faraday.default_adapter
        end
      end

      def run
        check_options
        run_rspec
        if !options.include?('-h') && !options.include?('--help')
          set_json_output
          jsonify
          format_results
          push_results
          cleanup
        end
      end

      def check_options
        options_has_format = options.include?('--format') || options.include?('-f')
        if dot_rspec = read_dot_rspec
          if options_has_format
            if dot_rspec.any? {|dot_opt| dot_opt.match(/--format|-f/)}
              options << dot_rspec.reject {|dot_opt| dot_opt.match(/--format|-f/)}
            else
              options << dot_rspec
            end
          end
        end

        if options_has_format
          self.options.flatten!
        else
          options.unshift('--format documentation')
        end

        # Don't pass the test/local flag from learn binary to rspec runner.
        options.delete("--test")
        options.delete("-t")
        options.delete("-l")
        options.delete("--local")

        self.keep_results = !!options.delete('--keep')
      end

      def read_dot_rspec
        if File.exist?('.rspec')
          File.readlines('.rspec').map(&:strip)
        else
          nil
        end
      end

      def run_rspec
        system("rspec #{options.join(' ')} --format j --out .results.json")
      end

      def set_json_output
        self.json_output = File.exists?('.results.json') ? File.read('.results.json') : nil
      end

      def jsonify
        self.parsed_output = json_output ? Oj.load(json_output, symbol_keys: true) : nil
      end

      def format_results
        self.formatted_results.merge!({
          username: username,
          github_user_id: user_id,
          repo_name: repo_name,
          build: {
            test_suite: [{
              framework: 'rspec',
              formatted_output: parsed_output,
              duration: parsed_output ? parsed_output[:summary][:duration] : nil
            }]
          },
          examples: parsed_output ? parsed_output[:summary][:example_count] : 1,
          passing_count: parsed_output ? parsed_output[:summary][:example_count] - parsed_output[:summary][:failure_count] - parsed_output[:summary][:pending_count] : 0,
          pending_count: parsed_output ? parsed_output[:summary][:pending_count] : 0,
          failure_count: parsed_output ? parsed_output[:summary][:failure_count] : 1,
          failure_descriptions: if parsed_output
            parsed_output[:examples].select do |example|
              example[:status] == "failed"
            end.map { |ex| ex[:full_description] }.join(";")
          else
            'A syntax error prevented RSpec from running.'
          end
        })
      end

      def push_results
        begin
          connection.post do |req|
            req.url SERVICE_ENDPOINT
            req.headers['Content-Type'] = 'application/json'
            req.body = Oj.dump(formatted_results, mode: :compat)
          end
        rescue Faraday::ConnectionFailed
          puts 'There was a problem connecting to Learn. Not pushing test results.'
        end
      end

      def cleanup
        FileUtils.rm('.results.json') unless keep_results? || !File.exist?('.results.json')
      end

      def keep_results?
        keep_results
      end
    end
  end
end

