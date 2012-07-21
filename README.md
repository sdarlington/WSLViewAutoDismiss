README: WSLViewAutoDismiss
---------------------------

The iOS documentation says that when an app goes into the background, certain
things should happen to avoid confusion when it comes back into the foreground.
One of those things is cancelling UIActionSheet's and UIAlertView's.

This project does exactly that automatically. As an added bonus, I also
added some init methods with blocks rather than delegates.

To include the library in one of your own projects, just drag the static
library into a sensible place your project. Xcode will do the rest. The
project also includes a tiny demo project.

Licence
-------

    /*
     * Copyright 2012 Stephen Darlington, Wandle Software Limited
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
