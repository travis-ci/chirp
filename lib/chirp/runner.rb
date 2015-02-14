require 'fileutils'

module Chirp
  class Runner
    Child = Struct.new(:script, :exitstatus)

    attr_reader :action

    def initialize(args = ARGV.clone)
      @action = args.first || 'scripts'
      $stdout.sync = true
      $stderr.sync = true
    end

    def run!
      send("perform_#{action}")
    end

    private

    def perform_pushback
      Process.exec(internal_script('pushback'))
    end

    def perform_dumplogs
      Process.exec(internal_script('dumplogs'), logs_dir)
    end

    def perform_scripts
      started = {}
      completed = []
      FileUtils.mkdir_p(logs_dir)

      scripts.each do |script|
        if File.executable?(script)
          logfile = File.join(logs_dir, "#{File.basename(script)}.log")
          $stdout.puts "* ---> Spawning #{script.inspect}"
          pid = Process.spawn(script, [:out, :err] => [logfile, 'w'])
          started[pid] = Child.new(script, 0)
        end
      end

      print_forever

      loop do
        break if started.empty?

        started.clone.map do |pid, child|
          if Process.waitpid(pid, Process::WNOHANG)
            child = started.delete(pid)
            child.exitstatus = $?.exitstatus
            $stdout.puts "---> Done with #{child.script.inspect}, exit #{child.exitstatus}"
            completed << child
          end
        end

        sleep 0.2
      end

      $stdout.puts "---> ALL DONE!"
      completed.map(&:exitstatus).reduce(:+) || 0
    end

    def scripts
      @scripts ||= Dir.glob(File.expand_path("#{scripts_dir}/*")).select do |script|
        script_filter =~ script
      end
    end

    def scripts_dir
      @scripts_dir ||= ENV.fetch(
        'CHIRP_SCRIPTS',
        File.expand_path('../scripts', __FILE__)
      )
    end

    def internal_script(basename)
      File.join(internal_scripts_dir, basename)
    end

    def internal_scripts_dir
      @internal_scripts_dir ||= File.expand_path('../internal-scripts', __FILE__)
    end

    def logs_dir
      @logs_dir ||= ENV.fetch('CHIRP_LOGS', File.expand_path('../../../log', __FILE__))
    end

    def script_filter
      @script_filter ||= %r{#{ENV['CHIRP_SCRIPT_FILTER'] || '.*'}}
    end

    def print_forever
      Thread.start do
        loop do
          %w(◴ ◷ ◶ ◵).each do |chr|
            $stderr.write "\r  "
            $stderr.write "\r#{chr} "
            sleep 0.1
          end
        end
      end
    end
  end
end
