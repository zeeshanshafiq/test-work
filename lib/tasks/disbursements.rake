namespace :disbursements do
  task process: :environment do
    Disbursement.process!
  end
end