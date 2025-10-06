//
//  RError.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import Foundation

enum RError {
    
    enum FetchDataError: String, Error{
        case badUrl = "Недействительная ссылка для запроса"
        case requestError = "Ошибка HTTP запроса. Проверьте свое интернет-соединение"
        case someError = "Произошла неизвестная ошибка"
        case emptyData = "Данные не были найдены"
        case retrivingDataError = "Не удалось получить данные с сервера. Попробуйте перезайти в аккаунт"
    }
    
    enum DownloadError: String, Error {
        case imageDownloadGeneralError = "Ошибка при скачивании картинки. Картинка либо не существует, либо недоступна"
        case imageDownloadInProgress = "Картинка грузится! Пожалуйста подождите"
    }
    
    enum VKError: String, Error {
        case expiredSession = "Время сессии истекло, пожалуйста авторизуйтесь вновь"
    }
    
}
