locals {
    rg_name          = "insurance-integration-services"
    appplan_name     = "${var.prefix}-appplan"
    function_name    = "${var.prefix}-function"
    api_plan_name    = "${var.prefix}-api-plan"
    soap_web_name    = "${var.prefix}-soap-api"
    rest_web_name    = "${var.prefix}-rest-api"
    app_insights_name    = "${var.prefix}-insights"
    apim_name    = "${var.prefix}-apim"

    apim_publisher_name = "Bob McLeek"
    apim_publisher_email = "Bob@memoryleek.co.uk"
}