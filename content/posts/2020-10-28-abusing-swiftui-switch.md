---
title: "Abusing the SwiftUI Switch Statement"
date: 2020-10-28T11:34:30+01:00
layout: post
categories: Eventail
tags:
 - SwiftUI
---

My now preferred way of handling complex if/else statements inside a SwiftUI view:

```swift
fileprivate struct ReminderTime: View {
  let date: Date
  let reminder: Reminder
  var body: some View {
    switch true {
    case reminder.dueDate == nil:
      Text("Reminder.Time.Nil")
    case Calendar.current.compare(reminder.dueDate!, to: date, toGranularity: .day) == .orderedAscending:
      Text(reminder.isCompleted ? "Reminder.Time.Done" :  "Reminder.Time.Overdue")
    case reminder.isAllDay && Calendar.current.isDate(date, inSameDayAs: reminder.dueDate!):
      Text("Reminder.Time.Today")
    case reminder.isAllDay:
      Text(reminder.dueDate!, style: .date)
    case !reminder.isCompleted && date > reminder.dueDate!:
      HStack {
        Image(systemName: "exclamationmark.triangle")
        Text(reminder.dueDate!, style: .time)
      }
    default:
      Text(reminder.dueDate!, style: .time)
    }
  }
}
```

At least until the `if let` construct will work.