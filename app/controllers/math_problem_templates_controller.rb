class MathProblemTemplatesController < ApplicationController
  def show
    @template = MathProblemTemplate.find(params[:id])
  end
end
