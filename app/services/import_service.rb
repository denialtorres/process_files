class ImportService < ApplicationService
  require('csv')

  def initialize(model, file)
    @total = 0
    @model = model
    @file = file
    @target = @model.to_s.downcase.pluralize
  end

  def call
    # csv = CSV.open(@file.tempfile, headers: true)
    csv = CSV.read(@file, headers: true)
    @total = csv.count


    csv.each_with_index do |row, index|
      @record = @model.new(row.to_hash)
      @record.save # ? import_success(index) : import_fail(index)
      update_progress_bar(index)
      @record.broadcast_append_to "import_#{@target}"
    end
  end

  private

  def update_progress_bar(index)
    Turbo::StreamsChannel.broadcast_update_to "import_#{@target}",
         target:'import_form',
         partial: 'layouts/shared/progress_bar',
         locals: { index: index+1, total: @total, percentage: percentage(index+1, @total) }
    sleep 0.01 # delay to update progress bar
  end

  # calculate the percentage of the progress_bar
  def percentage(index, total)
    (index)*100/total
  end
end
