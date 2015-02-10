class Chirp
  def initialize
    $stdout.sync = true
    $stderr.sync = true
  end

  def run!
    children = {}
    start_dots

    Dir.glob(scripts) do |script|
      if File.executable?(script)
        $stdout.puts "---> #{script.inspect}"
        pid = fork { system script }
        children[pid] = File.basename(script)
      end
    end

    loop do
      break if children.empty?

      children.clone.map do |pid, basename|
        children.delete(pid) if Process.waitpid(pid, Process::WNOHANG)
      end

      sleep 0.2
    end
  end

  def scripts
    @scripts ||= File.expand_path("#{scripts_dir}/*")
  end

  def scripts_dir
    @scripts_dir ||= ENV.fetch('CHIRP_SCRIPTS', File.expand_path('../../scripts', __FILE__))
  end

  def start_dots
    Thread.start do
      loop do
        $stderr.write '.'
        sleep 0.5
      end
    end
  end
end
