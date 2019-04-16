import json
import cv2
import MySQLdb

cam = cv2.VideoCapture("D:/opencv-3.4.4/samples/data/vtest.avi")
face_cascade = cv2.CascadeClassifier("D:/opencv-3.4.4/data/haarcascades/haarcascade_frontalface_default.xml")
while (cam.isOpened()):
    ret, frame = cam.read()
    frame = cv2.flip(frame, 1)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.1, 5)
    db = MySQLdb.Connect("localhost", "root", "admin", "head", charset='utf8')
    cursor = db.cursor()
    sql = "UPDATE place SET num = %s where id = %s" % (len(faces)*100, 1)
    try:
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    db.close()
    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
    cv2.imshow("Find Faces!", frame)
    c = cv2.waitKey(1)
    if c == 27:
        break

cam.release()
cv2.destroyAllWindows()
