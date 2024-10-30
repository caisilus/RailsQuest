class HomeController < ApplicationController
  def index
    @is_generate_allow = Character.count.zero? #если бд пустая, то можно сгенерировать новую случайную игру
  end

  #создает запись в бд с переданными параметрами(получает и разрешает параметры team и uni)
  def new_сharacter
    character = Character.new(params.require(:character).permit(:team, :unit))
    unless character.save
      flash[:alert] = character.errors.full_messages
    end
    redirect_to '/'
  end

  #создает 5 рыцарей, если в команде 1 есть хотя бы два мага и два рыцаря
  def ulta1_activate
    5.times do
      Character.create({ team: 1, unit: 'knight' })
    end
    redirect_to '/'
  end

  #удаляет 3 рандомных челиков, если в команде два есть 2 джинна и 1 медуза
  def ulta2_activate
    [3, Character.where(team: 1).count].min.times do |_|
      Character.where(team: 1).sample.destroy
    end
    redirect_to '/'
  end

  #удаляет всё, чтоб можно было начать с чистого листа
  def restart
    Character.destroy_all
    redirect_to '/'
  end

  # если лень создавать своих челиков после рестарта,то можно сгенерировать случайно четырех челиков из случайных команд
  # -Почему 4?
  # -просто, число прикольное)
  def generate_game
    4.times do
      Character.create_sample!
    end
    redirect_to '/'
  end
end