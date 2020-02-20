# /opt/redmine/config/unicorn.rb
# https://maeharin.hatenablog.com/entry/20130104/p1
# Unicornは複数のワーカーで起動するのでワーカー数を定義
# サーバーのメモリなどによって変更すること。
worker_processes 2
app_path = "/var/www/redmine"
# Nginxで使用する場合は以下の設定を行う。
listen File.expand_path('tmp/unicorn.sock', app_path)
# プロセスの停止などに必要なPIDファイルの保存先を指定。
pid File.expand_path('tmp/unicorn.pid', app_path)
stderr_path File.expand_path('log/unicorn.stderr.log', app_path)
stdout_path File.expand_path('log/unicorn.stdout.log', app_path)
# Unicornのエラーログと通常ログの位置を指定。
stderr_path File.expand_path('log/unicorn.stderr.log', app_path)
stdout_path File.expand_path('log/unicorn.stdout.log', app_path)

preload_app true
# 接続タイムアウト時間
timeout 30

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
