class WorksheetsController < ApplicationController
  include CurrentAssetManageable

  def index
    @worksheets = Worksheet.all
  end
  
  def create
    @worksheet = Worksheet.new(params[:worksheet].merge({:owner => current_user }))
    respond_to do |format|
      if @worksheet.save
        set_current_worksheet_in_session! @worksheet.id
        format.html { redirect_to(@worksheet, :notice => 'Worksheet was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end 
  end
  
  def show
    @worksheet = Worksheet.find(params[:id])
    set_current_worksheet_in_session! @worksheet.id
    redirect_to(edit_worksheet_path) if @worksheet.empty?
    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem }
  end
  
  def edit
    @worksheet = Worksheet.find(params[:id])
    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem }
  end
  
  def destroy
     @worksheet = Worksheet.find(params[:id])
     @worksheet.destroy    
    redirect_to my_worksheets_path
  end

  def update    
    @worksheet = Worksheet.find(params[:id])
    respond_to do |format|
      if @worksheet.update_attributes(params[:worksheet])
        format.html { redirect_to edit_worksheet_path(@worksheet), :notice => 'Worksheet was successfully updated.' }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    clear_current_worksheet_in_session!
    @worksheet = Worksheet.new
  end
end
