# frozen_string_literal: true
Flipflop.configure do
  feature :download_csv,
          default: true,
          description: "Allow the user to download a CSV template from the dashboard."

  feature :import_csv,
          default: true,
          description: "Allow the user to start a CSV import from the dashboard."
end
