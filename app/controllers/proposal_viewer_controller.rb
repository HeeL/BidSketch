class ProposalViewerController < ApplicationController
  
  def show
    proposal = Proposal.find(params[:id])
    client = proposal.client
    proposal_sections = []
    proposal.proposal_sections.each do |section|
      section_values = {
        :section_header => section.name,
        :section_content => section.description
      }
      proposal_sections.push(section_values)
    end

    template = Template.new('/public/proposal-template/index.html')
    
    variables = {
      :client_name => client.name,
      :client_website => client.website,
      :client_company => client.company,
      :proposal_name => proposal.name,
      :proposal_send_date => proposal.send_date,
      :proposal_user_name => proposal.user_name,
      :partial => {
        'proposal-content' => proposal_sections
      }
    }
    
    template.add_variables(variables)
    render :text => template.render
  end

end