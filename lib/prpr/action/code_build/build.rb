require 'aws-sdk-resources'

module Prpr
  module Action
    module CodeBuild
      class Build < Base
        def call
          if name = tag(event)
            start(build_commit, name)
          end
        end

        private

        def build_commit
          event.after
        end

        def tag(event)
          if event.ref =~ %r(staging/(.*))
            $1
          else
            nil
          end
        end

        def aws
          @aws ||= ::Aws::CodeBuild::Client.new(
            region: env[:code_build_region] || 'us-east-1',
            access_key_id: env[:code_build_aws_key],
            secret_access_key: env[:code_build_aws_secret],
          )
        end

        def start(commit_id, tag)
          aws.start_build({
            project_name: env[:code_build_project_name],
            source_version: commit_id,
            environment_variables_override: environment_variables(tag)
          })
        end

        def environment_variables(tag)
          aws.batch_get_projects({
              names: [env[:code_build_project_name]]
          }).projects.first.environment.environment_variables.map {|v|
            if v.name == 'IMAGE_TAG'
              { name: v.name, value: tag }
            else
              { name: v.name, value: v.value }
            end
          }
        end
      end
    end
  end
end
