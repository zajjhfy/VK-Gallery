//
//  RError.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import Foundation

enum RError: String, Error {
    case vkApiError = "Ошибка запроса к ВК"
    case badUrl = "Недействительная ссылка для запроса"
    case requestError = "Ошибка HTTP запроса. Проверьте свое интернет-соединение"
    case someError = "Произошла неизвестная ошибка"
    case emptyData = "Данные не были найдены"
    case retrivingDataError = "Не удалось получить данные с сервера"
}
