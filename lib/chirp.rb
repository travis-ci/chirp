class Chirp
  def run!
    children = []
    Dir.glob(scripts) do |script|
      if File.executable?(script)
        $stdout.puts "---> #{script.inspect}"
        children << fork { %x{#{script} &>/dev/null} }
      end
    end
    children.map { |pid| Process.waitpid(pid) }
  end

  def scripts
    @scripts ||= File.expand_path("#{scripts_dir}/*")
  end

  def scripts_dir
    @scripts_dir ||= ENV.fetch('CHIRP_SCRIPTS', File.expand_path('../../scripts', __FILE__))
  end
end
