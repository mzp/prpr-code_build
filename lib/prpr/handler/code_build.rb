module Prpr
    module Handler
      class CodeBuild < Base
        handle Event::Push do
          Action::CodeBuild::Build.new(event).call
        end
      end
    end
end
