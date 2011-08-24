class WorksheetBuilder
      
  def self.build(params)
    Worksheet.new(:owner => params[:owner], :title => params[:title])
  end
end