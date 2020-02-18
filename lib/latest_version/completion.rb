# frozen_string_literal: true

require 'fileutils'

module LatestVersion
  module Completion
    SOURCE_DIR = File.expand_path('../../completions', __dir__)
    SUPPORTED = Dir[File.join(SOURCE_DIR, 'latest_version.*')].sort.each_with_object({}) do |path, result|
      result.merge!(File.extname(path)[1..-1] => path)
    end

    class Install < Thor
      TARGET_DIRS = {
        bash: "#{ENV['HOME']}/.bash_completion.d",
        fish: "#{ENV['HOME']}/.config/fish/completions",
      }.freeze
      private_constant :TARGET_DIRS

      Completion::SUPPORTED.each do |shell, source_path|
        desc shell, "Installs #{shell} completion"
        define_method shell do
          target_path = File.join(TARGET_DIRS[shell.to_sym], File.basename(source_path))
          FileUtils.mkdir_p(File.dirname(target_path))
          FileUtils.cp(source_path, target_path)
          puts "#{shell} completion was written to #{target_path}"
          if shell == 'bash'
            tilde_target_path = target_path.gsub(ENV['HOME'], '~')
            return unless yes?(<<~MESSAGE)

              To take effect, the completion file needs to be read by your .bash_profile, eg:

              echo 'source "#{tilde_target_path}" >> ~/.bash_profile'

              Would you like us to set that up?
            MESSAGE

            File.open("#{ENV['HOME']}/.bash_profile", 'a') do |f|
              f << <<~SH
                # Completion for latest_version (https://rubygems.org/gems/latest_version)
                source "#{tilde_target_path}"
              SH
            end
          end
        end
      end
    end
  end
end
