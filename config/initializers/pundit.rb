# Rails.application.config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :not_found

#例外を403HTTPステータスにします。これを付けないと500になる｡
# :forbiddenというシンボルはステータスコード403と定義されている｡
Rails.application.config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden
