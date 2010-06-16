class EmailMailer < ActionMailer::Base  
  def email(campaign, campaign_recipient, sent_at = Time.now)
    email = campaign_recipient.is_a?(String) ? campaign_recipient : campaign_recipient.recipient.email

    subject    campaign.subject
    recipients email
    campaign_recipient.update_attribute(:sent_email, true) if !campaign_recipient.is_a?(String)
    
    if campaign.from_name.present?
      from     "#{campaign.from_name} <#{campaign.from}>"
    else
      from     campaign.from
    end

    sent_on    sent_at
    reply_to   campaign.reply_to
    
    if campaign.body.present?
      data = campaign.body
    else
      file = campaign.assets.html.data.url.split("?").first
      data = File.read(File.join(Rails.root, "public", file))
      data.gsub!("<head>", "<head>\n<base href='http://#{APP.host}/campaign/#{campaign.id}/images/' />")
    end

    body :data => data
    content_type 'text/html'
  end
end
