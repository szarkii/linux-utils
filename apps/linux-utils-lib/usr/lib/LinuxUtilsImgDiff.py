import cv2
import numpy as np
from PIL import Image as im

class ImageService:
    def __init__(self):
        self.kernel = np.ones((20, 20), np.uint8)

    def convert_to_gray(self, image):
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        gray = cv2.morphologyEx(gray, cv2.MORPH_CLOSE, self.kernel)
        gray = cv2.medianBlur(gray, 5)

        return gray

    def draw_contours(self, image, coordinates):
        x, y, w, h = coordinates
        cv2.rectangle(image, (x, y), (x + w, y + h), (0, 255, 0), 3)

        x2 = x + int(w / 2)
        y2 = y + int(h / 2)
        cv2.circle(image, (x2, y2), 4, (0, 255, 0), -1)

        text = "x: " + str(x2) + ", y: " + str(y2)
        cv2.putText(image, text, (x2 - 10, y2 - 10),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)
    
    def get_from_file(self, path):
        return cv2.imread(path)

    def save_to_file(self, path, image):
        data = im.fromarray(image)
        data.save(path)


class ImagesDifference:
    def __init__(self, first_image, second_image, similarity_threshold):
        self.first_image = first_image
        self.second_image = second_image
        self.similarity_threshold = similarity_threshold

    def calculate_difference(self):
        absolute_difference = cv2.absdiff(self.first_image, self.second_image)
        _, absolute_difference = cv2.threshold(absolute_difference, int(
            self.similarity_threshold), 255, cv2.THRESH_BINARY)
        contours, hierarchy = cv2.findContours(
            absolute_difference, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)[-2:]
        areas = [cv2.contourArea(c) for c in contours]

        if len(areas) < 1:
            self.images_different = False
        else:
            self.images_different = True
            x, y, w, h = cv2.boundingRect(contours[np.argmax(areas)])
            self.coordinates = (x, y, w, h)

    def are_different(self):
        return self.images_different

    def get_difference_coordinates(self):
        return self.coordinates

    def get_similarity_percentage(self):
        if self.images_different is False:
            return 0

        image_height, image_width = (self.second_image.shape)
        image_area = image_width * image_height
        _, _, difference_width, difference_height = (
            self.get_difference_coordinates())
        difference_area = difference_width + difference_height

        return difference_area / image_area * 100