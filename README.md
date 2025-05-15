# 🥮 VTCD_App - Vietnamese Traditional Cake Detection

**VTCD_App** is a mobile application built with Flutter that allows users to detect and identify different types of **Vietnamese traditional cakes** using object detection powered by **YOLOv8**.

The project combines a **Flutter-based frontend, a JavaScript (Node.js) backend, and a Python-based deep learning model** using **YOLOv8** for image recognition.

## 🎯 Purpose
This app aims to help users (especially tourists, food lovers, and cultural researchers) recognize various traditional Vietnamese cakes through a simple photo or camera capture, promoting cultural awareness and enhancing user experience with real-time detection.

### 🔧 System Architecture
- 📱 Frontend: Built with Flutter for cross-platform compatibility (Android/iOS).
- 🌐 Backend: Implemented using Node.js, serving as a bridge between the frontend and Python script.
- 🧠 Model: Uses **YOLOv8** (a state-of-the-art object detection model) to detect cakes in images.
- 🖼️ Image Flow:
  - User uploads or captures an image in the app.
  - Image is sent to the backend server.
  - Backend invokes a Python script with YOLOv8 model to perform detection.
  - Results (labels, confidence, bounding boxes) are returned to the app.
