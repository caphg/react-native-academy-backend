desc "This task is called by the Heroku scheduler add-on"
task :generate_report => :environment do
  vehicle_reports.each { |report| ReportsMailer.send_report(report).deliver }
end

def vehicle_report(vehicle)
  Trip
    .for_vehicle(vehicle)
    .for_current_month
    .map do |trip|
      {
        starting_distance: trip.starting_distance,
        ending_distance: trip.starting_distance + trip.total_distance,
        destination: trip.ending_point_name,
        description: trip.description,
        datetime: trip.created_at.strftime('%d-%m-%Y %I:%M'),
        is_official: trip.is_official
      }
    end
end

def vehicle_reports
  Vehicle.all.map do |vehicle|
    {
      email: vehicle.user.email,
      username: vehicle.user.name,
      carBrand: vehicle.car_brand,
      carYear: vehicle.year,
      carLicensePlates: vehicle.license_plate,
      report: vehicle_report(vehicle),
      total_official_distance: total_official_distance_for_vehicle(vehicle),
      total_unofficial_distance: total_unofficial_distance_for_vehicle(vehicle)
    }
  end
end

def total_official_distance_for_vehicle(vehicle)
  Trip
    .for_vehicle(vehicle)
    .for_current_month
    .official
    .reduce(0) do |sum, trip|
      sum + trip.total_distance
    end
end

def total_unofficial_distance_for_vehicle(vehicle)
  Trip
    .for_vehicle(vehicle)
    .for_current_month
    .unofficial
    .reduce(0) do |sum, trip|
      sum + trip.total_distance
    end
end
