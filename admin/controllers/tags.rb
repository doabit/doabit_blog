DoabitBlog::Admin.controllers :tags do
  get :index do
    @title = "Tags"
    @tags = Tag.all
    render 'tags/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'tag')
    @tag = Tag.new
    render 'tags/new'
  end

  post :create do
    @tag = Tag.new(params[:tag])
    if @tag.save
      @title = pat(:create_title, :model => "tag #{@tag.id}")
      flash[:success] = pat(:create_success, :model => 'Tag')
      params[:save_and_continue] ? redirect(url(:tags, :index)) : redirect(url(:tags, :edit, :id => @tag.id))
    else
      @title = pat(:create_title, :model => 'tag')
      flash.now[:error] = pat(:create_error, :model => 'tag')
      render 'tags/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "tag #{params[:id]}")
    @tag = Tag.find(params[:id])
    if @tag
      render 'tags/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'tag', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "tag #{params[:id]}")
    @tag = Tag.find(params[:id])
    if @tag
      if @tag.update_attributes(params[:tag])
        flash[:success] = pat(:update_success, :model => 'Tag', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:tags, :index)) :
          redirect(url(:tags, :edit, :id => @tag.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'tag')
        render 'tags/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'tag', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Tags"
    tag = Tag.find(params[:id])
    if tag
      if tag.destroy
        flash[:success] = pat(:delete_success, :model => 'Tag', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'tag')
      end
      redirect url(:tags, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'tag', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Tags"
    unless params[:tag_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'tag')
      redirect(url(:tags, :index))
    end
    ids = params[:tag_ids].split(',').map(&:strip).map(&:to_i)
    tags = Tag.find(ids)
    
    if Tag.destroy tags
    
      flash[:success] = pat(:destroy_many_success, :model => 'Tags', :ids => "#{ids.to_sentence}")
    end
    redirect url(:tags, :index)
  end
end
