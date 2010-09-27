README: UIViewAutoDismiss
-------------------------

In iOS4, apps are expected to remove alert views and action sheets before
transitioning to a background state. These classes make that process
a little less manual.

As as added bonus, it makes life on the iPad a little easier too. 
The HIG say that there is only supposed to be a single popup on-screen
at any time. This class with automatically dismiss other instances
when a new one is shown.

Licence
-------

    /*
     * Copyright 2010 Stephen Darlington
     *
     * Licensed under the Apache License, Version 2.0 (the "License");
     * you may not use this file except in compliance with the License.
     * You may obtain a copy of the License at
     *
     * http://www.apache.org/licenses/LICENSE-2.0
     *
     * Unless required by applicable law or agreed to in writing, software
     * distributed under the License is distributed on an "AS IS" BASIS,
     * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     * See the License for the specific language governing permissions and
     * limitations under the License.
     */
