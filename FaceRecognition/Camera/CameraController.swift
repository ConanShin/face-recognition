////
////  CameraController.swift
////  FaceRecognition
////
////  Created by Conan Shin on 2020/03/01.
////  Copyright © 2020 Conan Shin. All rights reserved.
////
//
//import AVFoundation
// 
//class CameraController {
//    var captureSession: AVCaptureSession?
// 
//    var currentCameraPosition: CameraPosition?
// 
//    var frontCamera: AVCaptureDevice?
//    var frontCameraInput: AVCaptureDeviceInput?
// 
//    var photoOutput: AVCapturePhotoOutput?
// 
//    var rearCamera: AVCaptureDevice?
//    var rearCameraInput: AVCaptureDeviceInput?
//}
// 
//extension CameraController {
//    func prepare(completionHandler: @escaping (Error?) -> Void) {
//        func createCaptureSession() {
//            self.captureSession = AVCaptureSession()
//        }
// 
//        func configureCaptureDevices() throws {
//            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
//            let cameras = (session.devices.compactMap { $0 }) // (session.devices.flatMap { $0 }), !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }
// 
//            for camera in cameras {
//                if camera.position == .front {
//                    self.frontCamera = camera
//                }
// 
//                if camera.position == .back {
//                    self.rearCamera = camera
// 
//                    try camera.lockForConfiguration()
//                    camera.focusMode = .autoFocus
//                    camera.unlockForConfiguration()
//                }
//            }
//        }
// 
//        func configureDeviceInputs() throws {
//            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
// 
//            if let rearCamera = self.rearCamera {
//                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
// 
//                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
// 
//                self.currentCameraPosition = .rear
//            }
// 
//            else if let frontCamera = self.frontCamera {
//                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
// 
//                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
//                else { throw CameraControllerError.inputsAreInvalid }
// 
//                self.currentCameraPosition = .front
//            }
// 
//            else { throw CameraControllerError.noCamerasAvailable }
//        }
// 
//        func configurePhotoOutput() throws {
//            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
// 
//            self.photoOutput = AVCapturePhotoOutput()
//            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
// 
//            if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
//            captureSession.startRunning()
//        }
// 
//        DispatchQueue(label: "prepare").async {
//            do {
//                createCaptureSession()
//                try configureCaptureDevices()
//                try configureDeviceInputs()
//                try configurePhotoOutput()
//            }
// 
//            catch {
//                DispatchQueue.main.async {
//                    completionHandler(error)
//                }
// 
//                return
//            }
// 
//            DispatchQueue.main.async {
//                completionHandler(nil)
//            }
//        }
//    }
//}
// 
//extension CameraController {
//    enum CameraControllerError: Swift.Error {
//        case captureSessionAlreadyRunning
//        case captureSessionIsMissing
//        case inputsAreInvalid
//        case invalidOperation
//        case noCamerasAvailable
//        case unknown
//    }
// 
//    public enum CameraPosition {
//        case front
//        case rear
//    }
//}
