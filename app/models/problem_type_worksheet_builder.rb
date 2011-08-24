class ProblemTypeWorksheetBuilder
      
  def self.create(params)
    Worksheet.create(:owner => params[:owner], :title => params[:title])
  end
end