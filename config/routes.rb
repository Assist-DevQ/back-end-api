Rails.application.routes.draw do
  mount Admin::RootApi => '/admin/api/v1'
end
