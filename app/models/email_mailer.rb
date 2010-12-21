class EmailMailer < ActionMailer::Base
  def accept_subscription(email, name, reject_code)
    subject 'Has aceptado su suscripción'
    recipients email
    from 'suscripciones@icas-sevilla.org'
    sent_on Time.now
    reply_to 'suscripciones@icas-sevilla.org'
    content_type 'text/html'
    body :name => name, :code => "http://#{APP.host}#{ConfirmationsController::REJECT_URL}/#{reject_code}"
  end

  def email(campaign, campaign_recipient, options = {})
    options = {:sent_at => Time.now, :confirmation_code => nil}.merge(options)

    email = campaign_recipient.is_a?(String) ? campaign_recipient : campaign_recipient.recipient.email
    subject    campaign.subject
    recipients email
    campaign_recipient.update_attribute(:sent_email, true) if !campaign_recipient.is_a?(String)

    if campaign.from_name.present?
      from     "#{campaign.from_name} <#{campaign.from}>"
    else
      from     campaign.from
    end

    sent_on    options[:sent_at]
    reply_to   campaign.reply_to

    if campaign.body.present?
      html = false
      data = campaign.body
    else
      html = true
      file = campaign.assets.html.data.url.split("?").first
      data = File.read(File.join(Rails.root, "public", file))
      data.gsub!("<head>", "<head>\n<base href='http://#{APP.host}/campaign/#{campaign.id}/images/' />")
    end


    campaign.email_attachments.each do |ea|
      attachment ea.data_content_type do |a| 
        a.body = File.read(File.join(Rails.root, "public", ea.data.url(:original, false)))
        a.filename = ea.data_file_name
      end 
    end

    subs = {}
    subs['aceptar'] = options[:confirmation_code].present? ? "http://#{APP.host}#{ConfirmationsController::ACCEPT_URL}/#{options[:confirmation_code].to_s}" : '#'
    subs['rechazar'] = options[:confirmation_code].present? ? "http://#{APP.host}#{ConfirmationsController::REJECT_URL}/#{options[:confirmation_code].to_s}" : '#'
    subs['nombre'] = options[:user_name].present? ? options[:user_name] : ''
    subs.each_pair do |key, value|
      data.gsub!("{{#{key}}}", value)
    end


    body :data => data, :html => html
    content_type 'text/html'
  end
end
