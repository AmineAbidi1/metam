# encoding: utf-8
module Metam

  # The Exceptions module handles exeptions related to missing scope, store, klass or attributes.
  module Exceptions

    # Handling exceptions related to missed {Metam::Scope}
    class UnknownScope < ::Exception
    end

    class UnknownSchema < ::Exception
    end

    class InvalidXML < ::Exception
    end
  end
end
