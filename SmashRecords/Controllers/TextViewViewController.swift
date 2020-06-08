//
//  TextViewViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class TextViewViewController: UIViewController, UITextViewDelegate {
    
    let realm = try! Realm()
    
    private var notes: Results<Note>?
    
    var selectedFighter = ""

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = selectedFighter
        loadNotes()
        
        guard notes?.count != 0 else {
            textView.text = ""
            return
        }
        textView.text = "\(notes![0].note)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // load notes
    func loadNotes() {
        notes = realm.objects(Note.self).filter("parentFighterName == %@", selectedFighter)
    }
    
    // save notes
    func save(note: Note) {
        do {
            try realm.write {
                realm.add(note, update: .modified)
            }
        } catch {
            print("Error saving notes \(error)")
        }
    }
    
    // when starting edit, appear done button
    func textViewDidBeginEditing(_ textView: UITextView) {
        let navigationItem: UIBarButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(self.donePressed))
        self.navigationItem.rightBarButtonItem = navigationItem
    }
    
    @objc func donePressed() {
        textView.resignFirstResponder()
        self.navigationItem.rightBarButtonItem = .none
        
        // save
        let newNote = Note()
        newNote.parentFighterName = selectedFighter
        newNote.note = textView.text!
        save(note: newNote)
    }


}

extension TextViewViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let newNote = Note()
        newNote.parentFighterName = selectedFighter
        newNote.note = textView.text!
        save(note: newNote)
    }

}
