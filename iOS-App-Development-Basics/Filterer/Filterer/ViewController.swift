//
//  ViewController.swift
//  Filterer
//
//  Created by Alexey Huralnyk on 11/4/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var secondaryMenu: UIView!
    @IBOutlet weak var sliderWidget: UIView!
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var originalCaption: UILabel!
    @IBOutlet var bottomMenuButtons: [UIButton]!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var originalImage = UIImage(named: "sample")!
    var filteredImage: UIImage!
    let imageProcessor = ImageProcessor(image: UIImage(named: "sample")!)
    var currentFilter: AdjustableFilter!
    
    let filters = [ Brightness(), Contrast(), Gamma(), Solarise(), ReverseSolarise(), Red(), Green(), Blue() ]
    
    
    
    // MARK: - Initialization
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        sliderWidget.translatesAutoresizingMaskIntoConstraints = false
        
        let touchRecognizer = UILongPressGestureRecognizer(target: self, action: "onImageViewTouch:")
        touchRecognizer.minimumPressDuration = 0.000001
        imageView.addGestureRecognizer(touchRecognizer)
        
        slider.continuous = false
        spinner.stopAnimating()
    }
    
    
    
    // MARK: - Comparing On Touch
    //
    
    func onImageViewTouch(gesture: UILongPressGestureRecognizer) {
        guard !compareButton.selected && filteredImage != nil else { return }
        
        if gesture.state == .Ended || gesture.state == .Cancelled {
            showFilteredImage(animated: true)
        } else {
            showOriginalImage(animated: true)
        }
    }
    
    func showOriginalImage(animated animated: Bool) {
        originalCaption.hidden = false
        imageView.setImage(originalImage, animated: animated)
    }
    
    func showFilteredImage(animated animated: Bool) {
        originalCaption.hidden = true
        imageView.setImage(filteredImage, animated: animated)
    }
    
    
    // MARK: - Bottom Menu Functionality
    //
    
    @IBAction func onNewPhoto(sender: UIButton) {
        deselectFilterButtonIfNeeded()
        deselectCompareButtonIfNeeded()
        deselectEditButtonIfNeeded()
        
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { _ in self.showCamera() }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { _ in self.showAlbum() }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onFilter(sender: UIButton) {
        deselectCompareButtonIfNeeded()
        deselectEditButtonIfNeeded()
        
        if sender.selected {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    @IBAction func onEdit(sender: UIButton) {
        deselectFilterButtonIfNeeded()
        deselectCompareButtonIfNeeded()
        
        if sender.selected {
            hideSliderWidget()
            sender.selected = false
        } else {
            showSliderWidget()
            sender.selected = true
        }
    }
    
    @IBAction func onCompare(sender: UIButton) {
        deselectFilterButtonIfNeeded()
        deselectEditButtonIfNeeded()
        
        if sender.selected {
            showFilteredImage(animated: true)
            sender.selected = false
        } else {
            showOriginalImage(animated: true)
            sender.selected = true
        }
    }
    
    @IBAction func onShare(sender: UIButton) {
        deselectFilterButtonIfNeeded()
        deselectCompareButtonIfNeeded()
        
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    func deselectFilterButtonIfNeeded() {
        if filterButton.selected {
            hideSecondaryMenu()
            filterButton.selected = false
        }
    }
    
    func deselectCompareButtonIfNeeded() {
        if compareButton.selected {
            showFilteredImage(animated: true)
            compareButton.selected = false
        }
    }
    
    func deselectEditButtonIfNeeded() {
        if editButton.selected {
            hideSliderWidget()
            editButton.selected = false
        }
    }
    
    func showCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.sourceType = .Camera
            presentViewController(cameraPicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Nice Try!", message: "To test camera run the app on the device with camera", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func showAlbum() {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .PhotoLibrary
        presentViewController(albumPicker, animated: true, completion: nil)
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        secondaryMenu.alpha = 0.0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }
    
    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0.0
            }) { completed in
                if completed {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    
    // MARK: - Secondary Menu
    //
    
    func processImageWithFilter(filter: Filter) {
        spinner.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.filteredImage = self.imageProcessor.applyFilter(filter)
            dispatch_async(dispatch_get_main_queue()) {
                self.showFilteredImage(animated: true)
                self.compareButton.enabled = true
                self.editButton.enabled = true
                self.spinner.stopAnimating()
            }
        }
    }
    
    
    // MARK: - Slider Widget
    //
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        currentFilter.modifier = Double(sender.value)
        processImageWithFilter(currentFilter)
        
    }
    
    func showSliderWidget() {
        slider.minimumValue = Float(currentFilter.minimumTreshold)
        slider.maximumValue = Float(currentFilter.maximumTreshold)
        slider.value = Float(currentFilter.modifier)
        
        view.addSubview(sliderWidget)
        
        let bottomConstraint = sliderWidget.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = sliderWidget.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderWidget.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = sliderWidget.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        sliderWidget.alpha = 0.0
        UIView.animateWithDuration(0.4) {
            self.sliderWidget.alpha = 1.0
        }
    }
    
    func hideSliderWidget() {
        UIView.animateWithDuration(0.4, animations: {
            self.sliderWidget.alpha = 0.0
            }) { completed in
                if completed {
                    self.sliderWidget.removeFromSuperview()
                }
        }
    }
    
    
    
    // MARK: - UI Image Picker Controller Delegate
    //
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            originalImage = rotateImage(image)
            resetUI()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resetUI() {
        hideSecondaryMenu()
        hideSliderWidget()
        currentFilter = nil
        filteredImage = nil
        compareButton.enabled = false
        editButton.enabled = false
        spinner.stopAnimating()
        imageProcessor.image = originalImage
        showOriginalImage(animated: false)
        collectionView.reloadData()
    }
}



// MARK: - UI Collection View Data Source & Delegate
//

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
        let processor = ImageProcessor(image: UIImage(named: "filter-button")!)
        let filter = filters[indexPath.row]
        filter.modifier = filter.maximumTreshold * 0.5
        cell.imageView.image = processor.applyFilter(filter)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentFilter = filters[indexPath.row]
        processImageWithFilter(currentFilter)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

