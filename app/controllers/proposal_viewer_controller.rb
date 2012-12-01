class ProposalViewerController < ApplicationController
  
  def show
    proposal = Proposal.find(params[:id])
    client = proposal.client
    section = ProposalSection.find_by_proposal_id(params[:id])
    template = Template.new('/public/proposal-template/index.html')
    variables = {
      :client_name => client.name,
      :client_website => client.website,
      :client_company => client.company,
      :proposal_name => proposal.name,
      :proposal_send_date => proposal.send_date,
      :proposal_user_name => proposal.user_name,
      :section_header => section.name,
      :section_content => section.description
    }
    template.add_variables(variables)
    render :text => template.render
  end

end