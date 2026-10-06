class BooksController < ApplicationController
    before_action :authenticate_author! 
    before_action :set_book, only: [:edit, :update, :destroy]
    before_action :authorize_owner!, only: [:edit, :update, :destroy]

    
    def index

        @filterrific = initialize_filterrific(
        Book,
        params[:filterrific],
        select_options: {
            with_author_id: Author.options_for_select
        }
        ) or return
        @books = @filterrific.find.page(params[:page])
        


        respond_to do |format|
        format.html
        format.csv{send_data @books.to_csv, filename: "books-#{Date.today}.csv"}
        end



    end

    def new
        @book=current_author.books.build
    end

    def create
        @book=current_author.books.build(book_params)

        if @book.save
            redirect_to books_path, notice: "Book Created Successfuly!!"

        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
    end

    def update
        if @book.update(book_params)
            redirect_to books_path, notice: "Book has been Updated !!! "
        else
            redirect_to :edit, status: :unprocessable_entity
        end
    end

    def destroy
    end

    private


    def set_book
        @book=Book.find(params[:id])
    end

    def authorize_owner!
        unless @book.author == current_author
            redirect_to books_path, alert: "You Only Modify Your Own Books!"
        end
    end


    def book_params
        params.require(:book).permit(:name, :release_date)
    end
end
