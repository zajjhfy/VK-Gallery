//
//  MockComments.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 08.10.2025.
//

import Foundation

struct Comment {
    let authorImage: String
    let authorLabel: String
    let authorComment: String
}

enum MockComments {
    static let comments = [
        Comment(
            authorImage: "https://randomuser.me/api/portraits/men/1.jpg",
            authorLabel: "Алексей Смирнов",
            authorComment: "Отличная фотография! Очень атмосферно 🌆"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/women/23.jpg",
            authorLabel: "Мария Кузнецова",
            authorComment: "Люблю такие кадры — прям хочется туда поехать 😍"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/men/45.jpg",
            authorLabel: "Иван Петров",
            authorComment: "Немного пересвечено, но всё равно круто 🔥"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/women/54.jpg",
            authorLabel: "Екатерина Волкова",
            authorComment: "А где это снято? Очень красивое место!"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/men/33.jpg",
            authorLabel: "Дмитрий Иванов",
            authorComment: "Добавил бы в любимые альбомы 📸"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/women/60.jpg",
            authorLabel: "Ольга Сергеева",
            authorComment: "Просто шикарно! Я уже десятый раз пересматриваю эту фотографию и каждый раз нахожу что-то новое. Композиция, свет, настроение — всё идеально!"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/men/72.jpg",
            authorLabel: "Павел Никитин",
            authorComment: "Есть ощущение, что снимок немного наклонён влево, но зато получился живой кадр, не постановочный. В таких фото и есть душа 📷"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/women/81.jpg",
            authorLabel: "Наталья Лебедева",
            authorComment: "Потрясающий закат! Наверное, это где-то у моря? Я бы с радостью посмотрела ещё фото из этой серии. Особенно, если есть вечерние кадры 🌅"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/men/90.jpg",
            authorLabel: "Сергей Волков",
            authorComment: "Местами зернистость заметна, но зато выглядит как кадр из старого фильма 🎞️ Очень крутая атмосфера!"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/women/95.jpg",
            authorLabel: "Анна Соколова",
            authorComment: "Этот снимок напомнил мне моё детство. У нас была похожая улица в деревне, и летом она выглядела точно так же. Спасибо за тёплые воспоминания ❤️"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/men/99.jpg",
            authorLabel: "Николай Жуков",
            authorComment: "Мне нравится, как ты работаешь с перспективой. Фон немного размыт, но это добавляет глубину. Жду ещё фото!"
        ),
        Comment(
            authorImage: "https://randomuser.me/api/portraits/women/100.jpg",
            authorLabel: "Татьяна Романова",
            authorComment: "Длинный комментарий для проверки переноса текста в ячейке. На маленьких экранах он должен переноситься корректно и не обрезаться. Очень важно, чтобы UILabel имел `numberOfLines = 0`, а Auto Layout учитывал высоту содержимого. Таким образом можно убедиться, что длинные комментарии отображаются корректно и красиво, не ломая дизайн 🖤"
        )
    ]
}

