from django.contrib.auth.models import User
from django.utils.timezone import now
from rest_framework.test import APITestCase
from rest_framework import status

right_now = now()
user_login_pass = {
    'username': 'o-lo-lo',
    'password': 'tro-lo-lo',
}


class TaskTestCase(APITestCase):

    def test_anonymous_post_task(self):
        data = {
            'user': 0,
            'title': 'Test',
            'priority': 'LOW',
            'content': 'Test',
            'complete_due': right_now,
            'done_at': right_now,
        }
        response = self.client.post('/api/tasks/', data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_task(self):
        user = User.objects.create_user(**user_login_pass)
        data = {
            'user': user.pk,
            'title': 'Test',
            'priority': 'LOW',
            'content': 'Test',
            'complete_due': right_now,
            'done_at': right_now,
        }
        self.client.login(**user_login_pass)
        response = self.client.post('/api/tasks/', data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        task_pk = response.json()['id']

        put_data = {
            'user': user.pk,
            'title': 'Test',
            'priority': 'MID',
            'content': 'Test',
            'complete_due': right_now,
            'done_at': right_now,
        }
        response = self.client.put(f'/api/tasks/{task_pk}/', put_data)
        self.assertEqual(response.json()['priority'], 'MID')

        response = self.client.delete(f'/api/tasks/{task_pk}/')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)


class CategoryTestCase(APITestCase):

    def test_anonymous_category(self):
        response = self.client.post('/api/categories/', {'name': 'Test'})
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_task(self):
        user = User.objects.create_user(**user_login_pass)
        data = {'name': 'Test'}
        self.client.login(**user_login_pass)
        response = self.client.post('/api/categories/', data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)


class StatisticTestCase(APITestCase):

    def test_statistic(self):
        user = User.objects.create_user(**user_login_pass)
        self.client.login(**user_login_pass)
        categories = [
            {"name": "Покупки"},
            {"name": "Дела"},
            {"name": "Досуг"},
            {"name": "Здоровье"},
        ]
        for category in categories:
            response = self.client.post('/api/categories/', category)
            category['id'] = response.json()['id']
            self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        tasks = [
            {
                "title": "Машина",
                "content": "Купить Бентли",
                "complete_due": "2023-10-04T20:00:00Z",
                "category": categories[0]['id'],
                "priority": "LOW",
            },
            {
                "title": "Резина",
                "content": "Купить летнюю резину",
                "done_at": "2023-10-05T17:35:56Z",
                "complete_due": "2023-11-04T20:00:00Z",
                "category": categories[0]['id'],
                "priority": "MID",
            },
            {
                "title": "Переобуться",
                "content": "",
                "complete_due": "2023-11-04T20:00:00Z",
                "category": categories[1]['id'],
                "priority": "HIGH",
            },
            {
                "title": "Отпуск",
                "content": "Съездить в Европу",
                "complete_due": "2023-10-04T20:00:00Z",
                "category": categories[2]['id'],
                "priority": "LOW",
            },
            {
                "title": "Мальдивы",
                "content": "Потусить",
                "category": categories[2]['id'],
                "priority": "MID",
            },
            {
                "title": "Накопить денег",
                "content": "",
                "category": categories[1]['id'],
                "priority": "MID",
            },
            {
                "title": "Купить путевку",
                "category": categories[1]['id'],
                "content": "",
                "priority": "MID",
            }
        ]

        for task in tasks:
            response = self.client.post('/api/tasks/', task)
            self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        response = self.client.get('/api/tasks/stat')
        self.assertEqual(response.json(), {
            'total_tasks_amount': 7,
            'done_tasks_amount': 1,
            'active_tasks_amount': 6,
            'expired_tasks_amount': 0,
            'avg_complete_hours': 703,
            'overdue_percent': 0.0
        })

        response = self.client.get('/api/categories/stat')
        self.assertEqual(response.json(), {
            '2': {'name': 'Покупки',
                  'stat': {'total_tasks_amount': 2,
                           'done_tasks_amount': 1,
                           'active_tasks_amount': 1,
                           'expired_tasks_amount': 0,
                           'avg_complete_hours': 703,
                           'overdue_percent': 0.0}},
            '3': {'name': 'Дела',
                  'stat': {
                      'total_tasks_amount': 3,
                      'done_tasks_amount': 0,
                      'active_tasks_amount': 3,
                      'expired_tasks_amount': 0,
                      'avg_complete_hours': 0,
                      'overdue_percent': 0.0}},
            '4': {'name': 'Досуг',
                  'stat': {'total_tasks_amount': 2,
                           'done_tasks_amount': 0,
                           'active_tasks_amount': 2,
                           'expired_tasks_amount': 0,
                           'avg_complete_hours': 0,
                           'overdue_percent': 0.0}},
            '5': {'name': 'Здоровье',
                  'stat': {'total_tasks_amount': 0,
                           'done_tasks_amount': 0,
                           'active_tasks_amount': 0,
                           'expired_tasks_amount': 0,
                           'avg_complete_hours': 0,
                           'overdue_percent': 0}}
        })
