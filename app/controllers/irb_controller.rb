class IrbController < ApplicationController
  def FormApps
  end

  def ArchivedApps
  
  @data = Document.where(:is_archived => '1')
  
  end

  def InProgressApps
  end

  def StateApps
  end
end
