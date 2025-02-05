from telethon import TelegramClient, events
import config
import requests

# تهيئة العميل
bot = TelegramClient('bot', config.API_ID, config.API_HASH).start(bot_token=config.BOT_TOKEN)

# حدث عند إرسال أمر /start
@bot.on(events.NewMessage(pattern='/start'))
async def start(event):
    await event.reply('مرحباً! أنا بوت بنترست. أرسل /صورة + اسم الصورة')

# حدث عند إرسال أمر /صورة
@bot.on(events.NewMessage(pattern='/صورة (.*)'))
async def pinterest(event):
    query = event.pattern_match.group(1)
    chat_id = event.chat_id

    # جلب الصور من API
    try:
        response = requests.get(f"https://pinterest-api-one.vercel.app/?q={query}")
        images = response.json().get('images', [])[:6]  # إرسال 6 صور كحد أقصى
    except Exception as e:
        await event.reply(f"حدث خطأ: {e}")
        return

    if not images:
        await event.reply("لم أجد أي صور 😢")
        return

    # إرسال الصور كمجموعة
    await bot.send_message(chat_id, "جارٍ إرسال الصور...")
    media = []
    for url in images:
        media.append(InputMediaPhoto(url))  # استخدام InputMediaPhoto من Telethon

    await bot.send_file(chat_id, media, caption=f"نتائج البحث عن: {query}")

# تشغيل البوت
if __name__ == "__main__":
    print("تم تشغيل البوت بنجاح!")
    bot.run_until_disconnected()
