class Api::V1::CompaniesController < ApplicationController
  def index
    companies = Company.filtered_companies(permitted_params)

    render json: {
      companies: ActiveModelSerializers::SerializableResource.new(companies, each_serializer: CompanySerializer).as_json,
      meta: {
        page: companies.current_page,
        pages: companies.total_pages
      }
    }
  end

  private

  def permitted_params
    params.permit(:companyName, :industry, :minEmployee, :minimumDealAmount, :page)
  end
end
