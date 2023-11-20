# frozen_string_literal: true

require 'securerandom'

# Esbuild wrapper spawn esbuild to build js bundle
class EsbuildWrapper
  BIN_PATH = 'node_modules/.bin/esbuild'

  def bundle
    command = BIN_PATH
    file_name = SecureRandom.uuid

    command += ' --bundle'
    command += " --outfile=./build/#{file_name}.js"
    command += ' --target=es2020'
    command += ' --format=esm'
    command += ' --alias:step_main=./src/index.js'
    command += ' js_template/index.js'

    spawn(command)
  end

  def spawn(command)
    rd, wr = IO.pipe

    pid = fork do
      rd.close

      $stdout.reopen(wr)
      exec(command)
    end

    wr.close

    Process.waitpid(pid)

    rd.read
  end
end

bundler = EsbuildWrapper.new
print bundler.bundle
