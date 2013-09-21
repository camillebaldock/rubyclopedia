=begin
Copyright (C) 2013 Camille_LDN
Rubyclopedia is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
Rubyclopedia is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end
class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order('published_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes }
    end
  end

  def show
    @episode = Episode.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @episode }
    end
  end

  def watched
    raise 'Not in use for minimal usable subset: sprint 1; planned for future releases'
  end
end
