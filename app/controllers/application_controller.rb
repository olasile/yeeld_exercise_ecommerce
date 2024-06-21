class ApplicationController < ActionController::Base
  rescue_from StandardError do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, flash: { notice: exception.message } }
      format.turbo_stream do
        flash.now[:notice] = exception.message
        render_flash
      end
    end
  end

  def render_flash
    render turbo_stream: turbo_stream.update('flash_messages', partial: 'application/flash')
  end
end
