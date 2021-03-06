from django.conf.urls import patterns, include, url
from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'bep.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^test/', 'user_entry.views.index'),
    url(r'^', include('user_entry.urls')),

    #url(r'^user_entry/', include('user_entry.urls')),

    (r'^messages/', include('django_messages.urls')),
    (r'^books/', include('books.urls')),


)
