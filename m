
import requests
import json 
import telebot
import random
from telebot import types

API_TOKEN = '6470810240:AAGFhd9et-bakCB1zrwTD-A9M4AL4FiAsUc'

bot = telebot.TeleBot(API_TOKEN)
TC4 = types.InlineKeyboardButton(text ="المطور",url="tg://user?id=5539139939")
AIM = types.InlineKeyboardButton(text ="تحديثات البوت",url="https://t.me/KC1KK")
X = types.InlineKeyboardButton(text ="أضافة للمجموعة",url="https://t.me/vvv5zzbot?startgroup")
HLTV = types.InlineKeyboardButton(text ="أضافة للقناة",url="https://t.me/vvv5zzbot?starTC4hannel")


@bot.message_handler(commands=['start'])
def start(message):
         C4_= types.InlineKeyboardMarkup()
         C4_.row_width = 2
         C4_.add(AIM,TC4,X,HLTV)
         photo = f"t.me/{message.from_user.username}"
         name_of_tc4= f"{message.from_user.first_name}"
         text = f"✨اهلا وسهلا {name_of_tc4} \n أنا بوت تفاعل في المجموعة أو القناة \n التفاعلات المدعومة
"(👍❤️🔥👏❤️‍🔥😘😭😎🗿💋🍓😢💔🥰)\n يجب تفعيلها ليعمل البوت بشكل صحيح
         bot.send_photo(message.chat.id,photo,text ,
 parse_mode="Markdown",reply_markup=C4_)

@bot.message_handler(func=lambda message: True)
def start(message):
    reactions = ["😭","👍","❤️","🔥","👏","❤️‍🔥","😘","😎","🗿","💋","🍓","😢","💔","🥰"]
    emoji = random.choice(reactions)
    response = send_message_react(
        {
            'chat_id': message.chat.id,
            'message_id': message.message_id,
            'reaction': json.dumps([{'type': "emoji", "emoji": emoji}])
        }
    )
    

def send_message_react(datas={}):
    url = "https://api.telegram.org/bot" + API_TOKEN + "/" + 'setmessagereaction'
    response = requests.post(url, data=datas)

    if response.status_code != 200:
        return "Error: " + response.text
    else:
        return response.json()

bot.infinity_polling()
