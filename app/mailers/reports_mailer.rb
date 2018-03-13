class ReportsMailer < ApplicationMailer
  def send_report(data)
    @data = data
    @total_official_distance = data[:total_official_distance]
    @total_unofficial_distance = data[:total_unofficial_distance]
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(
        :pdf => "Vehicle Report for #{Date.today.month}/#{Date.today.year}",
        :template => 'reports_mailer/send_report.html.erb',
        layout: 'mailer.html.erb'
      )
    )
    attachments['vehicle_report.pdf'] = pdf
    mail(to: data[:email], subject: "Vehicle Report for #{Date.today.month}/#{Date.today.year}")
  end
end
