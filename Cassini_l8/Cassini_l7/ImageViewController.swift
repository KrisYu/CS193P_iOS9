//
//  ImageViewController.swift
//  Cassini_l7
//
//  Created by 雪 禹 on 6/8/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
        {
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    
    var imageURL: NSURL? {
        didSet {
            image = nil
            //make sure the image on screen
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                let contentsOfURL = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL{
                    if let imageData = contentsOfURL {
                        self.image = UIImage(data:  imageData)
                    } else {
                        self.spinner?.stopAnimating()
                    }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }

    private var imageView = UIImageView()
    
    private var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }

}
