Rails.application.routes.draw do
  mount Admin::RootApi => '/admin/api/v1'
  mount Extension::RootApi => '/extension/api/v1'
  mount Common::WebHooksApi => '/api/v1/hooks'
end
