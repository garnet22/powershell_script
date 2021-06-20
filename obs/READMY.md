#Запуск obs в трее при RDP сессии

1. enter_schedule - создаёт schedule task с тригерами на logon или connect к существующей сессии
с запуском obs в трее.
2. exit_schedule - добавляет schedule task - kill obs из сессии.
3. run.ps1, exit.ps1 - файлы запуска, удаления из закрытия obs соответственно.