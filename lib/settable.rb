module Settable
  def jira_settings
    Settings
      .jira
      .deep_symbolize_keys
  end
end
