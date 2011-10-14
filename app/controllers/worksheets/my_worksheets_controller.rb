class Worksheets::MyWorksheetsController < ApplicationController
  include CurrentAssetManageable
  def index
    clear_current_worksheet_in_session!
    @worksheets = Worksheet.find_all_by_owner_id(current_user)
  end  
end
