/*

 FullCalendar v1.5.4
 http://arshaw.com/fullcalendar/

 Use fullcalendar.css for basic styling.
 For event drag & drop, requires jQuery UI draggable.
 For event resizing, requires jQuery UI resizable.

 Copyright (c) 2011 Adam Shaw
 Dual licensed under the MIT and GPL licenses, located in
 MIT-LICENSE.txt and GPL-LICENSE.txt respectively.

 Date: Tue Sep 4 23:38:33 2012 -0700

*/
(function (m, ma) {
    function wb(a) {
        m.extend(true, Ya, a)
    }
    function Yb(a, b, e) {
        function d(k) {
            if (E) {
                u();
                q();
                na();
                S(k)
            } else f()
        }
        function f() {
            B = b.theme ? "ui" : "fc";
            a.addClass("fc");
            b.isRTL && a.addClass("fc-rtl");
            b.theme && a.addClass("ui-widget");
            E = m("<div class='fc-content' style='position:relative'/>").prependTo(a);
            C = new Zb(X, b);
            (P = C.render()) && a.prepend(P);
            y(b.defaultView);
            m(window).resize(oa);
            t() || g()
        }
        function g() {
            setTimeout(function () {
                !n.start && t() && S()
            }, 0)
        }
        function l() {
            m(window).unbind("resize", oa);
            C.destroy();
            E.remove();
            a.removeClass("fc fc-rtl ui-widget")
        }
        function j() {
            return i.offsetWidth !== 0
        }
        function t() {
            return m("body")[0].offsetWidth !== 0
        }
        function y(k) {
            if (!n || k != n.name) {
                F++;
                pa();
                var D = n,
                    Z;
                if (D) {
                    (D.beforeHide || xb)();
                    Za(E, E.height());
                    D.element.hide()
                } else Za(E, 1);
                E.css("overflow", "hidden");
                if (n = Y[k]) n.element.show();
                else n = Y[k] = new Ja[k](Z = s = m("<div class='fc-view fc-view-" + k + "' style='position:absolute'/>").appendTo(E), X);
                D && C.deactivateButton(D.name);
                C.activateButton(k);
                S();
                E.css("overflow", "");
                D && Za(E, 1);
                Z || (n.afterShow || xb)();
                F--
            }
        }
        function S(k) {
            if (j()) {
                F++;
                pa();
                o === ma && u();
                var D = false;
                if (!n.start || k || r < n.start || r >= n.end) {
                    n.render(r, k || 0);
                    fa(true);
                    D = true
                } else if (n.sizeDirty) {
                    n.clearEvents();
                    fa();
                    D = true
                } else if (n.eventsDirty) {
                    n.clearEvents();
                    D = true
                }
                n.sizeDirty = false;
                n.eventsDirty = false;
                ga(D);
                W = a.outerWidth();
                C.updateTitle(n.title);
                k = new Date;
                k >= n.start && k < n.end ? C.disableButton("today") : C.enableButton("today");
                F--;
                n.trigger("viewDisplay", i)
            }
        }
        function Q() {
            q();
            if (j()) {
                u();
                fa();
                pa();
                n.clearEvents();
                n.renderEvents(J);
                n.sizeDirty = false
            }
        }
        function q() {
            m.each(Y, function (k, D) {
                D.sizeDirty = true
            })
        }
        function u() {
            o = b.contentHeight ? b.contentHeight : b.height ? b.height - (P ? P.height() : 0) - Sa(E) : Math.round(E.width() / Math.max(b.aspectRatio, 0.5))
        }
        function fa(k) {
            F++;
            n.setHeight(o, k);
            if (s) {
                s.css("position", "relative");
                s = null
            }
            n.setWidth(E.width(), k);
            F--
        }
        function oa() {
            if (!F) if (n.start) {
                var k = ++v;
                setTimeout(function () {
                    if (k == v && !F && j()) if (W != (W = a.outerWidth())) {
                        F++;
                        Q();
                        n.trigger("windowResize", i);
                        F--
                    }
                }, 200)
            } else g()
        }
        function ga(k) {
            if (!b.lazyFetching || ya(n.visStart, n.visEnd)) ra();
            else k && da()
        }
        function ra() {
            K(n.visStart, n.visEnd)
        }
        function sa(k) {
            J = k;
            da()
        }
        function ha(k) {
            da(k)
        }
        function da(k) {
            na();
            if (j()) {
                n.clearEvents();
                n.renderEvents(J, k);
                n.eventsDirty = false
            }
        }
        function na() {
            m.each(Y, function (k, D) {
                D.eventsDirty = true
            })
        }
        function ua(k, D, Z) {
            n.select(k, D, Z === ma ? true : Z)
        }
        function pa() {
            n && n.unselect()
        }
        function U() {
            S(-1)
        }
        function ca() {
            S(1)
        }
        function ka() {
            gb(r, -1);
            S()
        }
        function qa() {
            gb(r, 1);
            S()
        }
        function G() {
            r = new Date;
            S()
        }
        function p(k, D, Z) {
            if (k instanceof Date) r = N(k);
            else yb(r, k, D, Z);
            S()
        }
        function L(k, D, Z) {
            k !== ma && gb(r, k);
            D !== ma && hb(r, D);
            Z !== ma && ba(r, Z);
            S()
        }
        function c() {
            return N(r)
        }
        function z() {
            return n
        }
        function H(k, D) {
            if (D === ma) return b[k];
            if (k == "height" || k == "contentHeight" || k == "aspectRatio") {
                b[k] = D;
                Q()
            }
        }
        function T(k, D) {
            if (b[k]) return b[k].apply(D || i, Array.prototype.slice.call(arguments, 2))
        }
        var X = this;
        X.options = b;
        X.render = d;
        X.destroy = l;
        X.refetchEvents = ra;
        X.reportEvents = sa;
        X.reportEventChange = ha;
        X.rerenderEvents = da;
        X.changeView = y;
        X.select = ua;
        X.unselect = pa;
        X.prev = U;
        X.next = ca;
        X.prevYear = ka;
        X.nextYear = qa;
        X.today = G;
        X.gotoDate = p;
        X.incrementDate = L;
        X.formatDate = function (k, D) {
            return Oa(k, D, b)
        };
        X.formatDates = function (k, D, Z) {
            return ib(k, D, Z, b)
        };
        X.getDate = c;
        X.getView = z;
        X.option = H;
        X.trigger = T;
        $b.call(X, b, e);
        var ya = X.isFetchNeeded,
            K = X.fetchEvents,
            i = a[0],
            C, P, E, B, n, Y = {}, W, o, s, v = 0,
            F = 0,
            r = new Date,
            J = [],
            M;
        yb(r, b.year, b.month, b.date);
        b.droppable && m(document).bind("dragstart", function (k, D) {
            var Z = k.target,
                ja = m(Z);
            if (!ja.parents(".fc").length) {
                var ia = b.dropAccept;
                if (m.isFunction(ia) ? ia.call(Z, ja) : ja.is(ia)) {
                    M = Z;
                    n.dragStart(M, k, D)
                }
            }
        }).bind("dragstop", function (k, D) {
            if (M) {
                n.dragStop(M, k, D);
                M = null
            }
        })
    }
    function Zb(a, b) {
        function e() {
            q = b.theme ? "ui" : "fc";
            if (b.header) return Q = m("<table class='fc-header' style='width:100%'/>").append(m("<tr/>").append(f("left")).append(f("center")).append(f("right")))
        }
        function d() {
            Q.remove()
        }
        function f(u) {
            var fa = m("<td class='fc-header-" + u + "'/>");
            (u = b.header[u]) && m.each(u.split(" "), function (oa) {
                oa > 0 && fa.append("<span class='fc-header-space'/>");
                var ga;
                m.each(this.split(","), function (ra, sa) {
                    if (sa == "title") {
                        fa.append("<span class='fc-header-title'><h2>&nbsp;</h2></span>");
                        ga && ga.addClass(q + "-corner-right");
                        ga = null
                    } else {
                        var ha;
                        if (a[sa]) ha = a[sa];
                        else if (Ja[sa]) ha = function () {
                            na.removeClass(q + "-state-hover");
                            a.changeView(sa)
                        };
                        if (ha) {
                            ra = b.theme ? jb(b.buttonIcons, sa) : null;
                            var da = jb(b.buttonText, sa),
                                na = m("<span class='fc-button fc-button-" + sa + " " + q + "-state-default'><span class='fc-button-inner'><span class='fc-button-content'>" + (ra ? "<span class='fc-icon-wrap'><span class='ui-icon ui-icon-" + ra + "'/></span>" : da) + "</span><span class='fc-button-effect'><span></span></span></span></span>");
                            if (na) {
                                na.click(function () {
                                    na.hasClass(q + "-state-disabled") || ha()
                                }).mousedown(function () {
                                    na.not("." + q + "-state-active").not("." + q + "-state-disabled").addClass(q + "-state-down")
                                }).mouseup(function () {
                                    na.removeClass(q + "-state-down")
                                }).hover(function () {
                                    na.not("." + q + "-state-active").not("." + q + "-state-disabled").addClass(q + "-state-hover")
                                }, function () {
                                    na.removeClass(q + "-state-hover").removeClass(q + "-state-down")
                                }).appendTo(fa);
                                ga || na.addClass(q + "-corner-left");
                                ga = na
                            }
                        }
                    }
                });
                ga && ga.addClass(q + "-corner-right")
            });
            return fa
        }
        function g(u) {
            Q.find("h2").html(u)
        }
        function l(u) {
            Q.find("span.fc-button-" + u).addClass(q + "-state-active")
        }
        function j(u) {
            Q.find("span.fc-button-" + u).removeClass(q + "-state-active")
        }
        function t(u) {
            Q.find("span.fc-button-" + u).addClass(q + "-state-disabled")
        }
        function y(u) {
            Q.find("span.fc-button-" + u).removeClass(q + "-state-disabled")
        }
        var S = this;
        S.render = e;
        S.destroy = d;
        S.updateTitle = g;
        S.activateButton = l;
        S.deactivateButton = j;
        S.disableButton = t;
        S.enableButton = y;
        var Q = m([]),
            q
    }
    function $b(a, b) {
        function e(c, z) {
            return !ca || c < ca || z > ka
        }
        function d(c, z) {
            ca = c;
            ka = z;
            L = [];
            c = ++qa;
            G = z = U.length;
            for (var H = 0; H < z; H++) f(U[H], c)
        }
        function f(c, z) {
            g(c, function (H) {
                if (z == qa) {
                    if (H) {
                        for (var T = 0; T < H.length; T++) {
                            H[T].source = c;
                            oa(H[T])
                        }
                        L = L.concat(H)
                    }
                    G--;
                    G || ua(L)
                }
            })
        }
        function g(c, z) {
            var H, T = Aa.sourceFetchers,
                X;
            for (H = 0; H < T.length; H++) {
                X = T[H](c, ca, ka, z);
                if (X === true) return;
                else if (typeof X == "object") {
                    g(X, z);
                    return
                }
            }
            if (H = c.events) if (m.isFunction(H)) {
                u();
                H(N(ca), N(ka), function (C) {
                    z(C);
                    fa()
                })
            } else m.isArray(H) ? z(H) : z();
            else if (c.url) {
                var ya = c.success,
                    K = c.error,
                    i = c.complete;
                H = m.extend({}, c.data || {});
                T = Ta(c.startParam, a.startParam);
                X = Ta(c.endParam, a.endParam);
                if (T) H[T] = Math.round(+ca / 1E3);
                if (X) H[X] = Math.round(+ka / 1E3);
                u();
                m.ajax(m.extend({}, ac, c, {
                    data: H,
                    success: function (C) {
                        C = C || [];
                        var P = $a(ya, this, arguments);
                        if (m.isArray(P)) C = P;
                        z(C)
                    },
                    error: function () {
                        $a(K, this, arguments);
                        z()
                    },
                    complete: function () {
                        $a(i, this, arguments);
                        fa()
                    }
                }))
            } else z()
        }
        function l(c) {
            if (c = j(c)) {
                G++;
                f(c, qa)
            }
        }
        function j(c) {
            if (m.isFunction(c) || m.isArray(c)) c = {
                events: c
            };
            else if (typeof c == "string") c = {
                url: c
            };
            if (typeof c == "object") {
                ga(c);
                U.push(c);
                return c
            }
        }
        function t(c) {
            U = m.grep(U, function (z) {
                return !ra(z, c)
            });
            L = m.grep(L, function (z) {
                return !ra(z.source, c)
            });
            ua(L)
        }
        function y(c) {
            var z, H = L.length,
                T, X = na().defaultEventEnd,
                ya = c.start - c._start,
                K = c.end ? c.end - (c._end || X(c)) : 0;
            for (z = 0; z < H; z++) {
                T = L[z];
                if (T._id == c._id && T != c) {
                    T.start = new Date(+T.start + ya);
                    T.end = c.end ? T.end ? new Date(+T.end + K) : new Date(+X(T) + K) : null;
                    T.title = c.title;
                    T.url = c.url;
                    T.allDay = c.allDay;
                    T.className = c.className;
                    T.editable = c.editable;
                    T.color = c.color;
                    T.backgroudColor = c.backgroudColor;
                    T.borderColor = c.borderColor;
                    T.textColor = c.textColor;
                    oa(T)
                }
            }
            oa(c);
            ua(L)
        }
        function S(c, z) {
            oa(c);
            if (!c.source) {
                if (z) {
                    pa.events.push(c);
                    c.source = pa
                }
                L.push(c)
            }
            ua(L)
        }
        function Q(c) {
            if (c) {
                if (!m.isFunction(c)) {
                    var z = c + "";
                    c = function (T) {
                        return T._id == z
                    }
                }
                L = m.grep(L, c, true);
                for (H = 0; H < U.length; H++) if (m.isArray(U[H].events)) U[H].events = m.grep(U[H].events, c, true)
            } else {
                L = [];
                for (var H = 0; H < U.length; H++) if (m.isArray(U[H].events)) U[H].events = []
            }
            ua(L)
        }
        function q(c) {
            if (m.isFunction(c)) return m.grep(L, c);
            else if (c) {
                c += "";
                return m.grep(L, function (z) {
                    return z._id == c
                })
            }
            return L
        }
        function u() {
            p++ || da("loading", null, true)
        }
        function fa() {
            --p || da("loading", null, false)
        }
        function oa(c) {
            var z = c.source || {}, H = Ta(z.ignoreTimezone, a.ignoreTimezone);
            c._id = c._id || (c.id === ma ? "_fc" + bc++ : c.id + "");
            if (c.date) {
                if (!c.start) c.start = c.date;
                delete c.date
            }
            c._start = N(c.start = kb(c.start, H));
            c.end = kb(c.end,
            H);
            if (c.end && c.end <= c.start) c.end = null;
            c._end = c.end ? N(c.end) : null;
            if (c.allDay === ma) c.allDay = Ta(z.allDayDefault, a.allDayDefault);
            if (c.className) {
                if (typeof c.className == "string") c.className = c.className.split(/\s+/)
            } else c.className = []
        }
        function ga(c) {
            if (c.className) {
                if (typeof c.className == "string") c.className = c.className.split(/\s+/)
            } else c.className = [];
            for (var z = Aa.sourceNormalizers, H = 0; H < z.length; H++) z[H](c)
        }
        function ra(c, z) {
            return c && z && sa(c) == sa(z)
        }
        function sa(c) {
            return (typeof c == "object" ? c.events || c.url : "") || c
        }
        var ha = this;
        ha.isFetchNeeded = e;
        ha.fetchEvents = d;
        ha.addEventSource = l;
        ha.removeEventSource = t;
        ha.updateEvent = y;
        ha.renderEvent = S;
        ha.removeEvents = Q;
        ha.clientEvents = q;
        ha.normalizeEvent = oa;
        var da = ha.trigger,
            na = ha.getView,
            ua = ha.reportEvents,
            pa = {
                events: []
            }, U = [pa],
            ca, ka, qa = 0,
            G = 0,
            p = 0,
            L = [];
        for (ha = 0; ha < b.length; ha++) j(b[ha])
    }
    function gb(a, b, e) {
        a.setFullYear(a.getFullYear() + b);
        e || Ka(a);
        return a
    }
    function hb(a, b, e) {
        if (+a) {
            b = a.getMonth() + b;
            var d = N(a);
            d.setDate(1);
            d.setMonth(b);
            a.setMonth(b);
            for (e || Ka(a); a.getMonth() != d.getMonth();) a.setDate(a.getDate() + (a < d ? 1 : -1))
        }
        return a
    }
    function ba(a, b, e) {
        if (+a) {
            b = a.getDate() + b;
            var d = N(a);
            d.setHours(9);
            d.setDate(b);
            a.setDate(b);
            e || Ka(a);
            lb(a, d)
        }
        return a
    }
    function lb(a, b) {
        if (+a) for (; a.getDate() != b.getDate();) a.setTime(+a + (a < b ? 1 : -1) * cc)
    }
    function xa(a, b) {
        a.setMinutes(a.getMinutes() + b);
        return a
    }
    function Ka(a) {
        a.setHours(0);
        a.setMinutes(0);
        a.setSeconds(0);
        a.setMilliseconds(0);
        return a
    }
    function N(a, b) {
        if (b) return Ka(new Date(+a));
        return new Date(+a)
    }
    function zb() {
        var a = 0,
            b;
        do b = new Date(1970,
        a++, 1);
        while (b.getHours());
        return b
    }
    function Fa(a, b, e) {
        for (b = b || 1; !a.getDay() || e && a.getDay() == 1 || !e && a.getDay() == 6;) ba(a, b);
        return a
    }
    function Ca(a, b) {
        return Math.round((N(a, true) - N(b, true)) / Ab)
    }
    function yb(a, b, e, d) {
        if (b !== ma && b != a.getFullYear()) {
            a.setDate(1);
            a.setMonth(0);
            a.setFullYear(b)
        }
        if (e !== ma && e != a.getMonth()) {
            a.setDate(1);
            a.setMonth(e)
        }
        d !== ma && a.setDate(d)
    }
    function kb(a, b) {
        if (typeof a == "object") return a;
        if (typeof a == "number") return new Date(a * 1E3);
        if (typeof a == "string") {
            if (a.match(/^\d+(\.\d+)?$/)) return new Date(parseFloat(a) * 1E3);
            if (b === ma) b = true;
            return Bb(a, b) || (a ? new Date(a) : null)
        }
        return null
    }
    function Bb(a, b) {
        a = a.match(/^([0-9]{4})(-([0-9]{2})(-([0-9]{2})([T ]([0-9]{2}):([0-9]{2})(:([0-9]{2})(\.([0-9]+))?)?(Z|(([-+])([0-9]{2})(:?([0-9]{2}))?))?)?)?)?$/);
        if (!a) return null;
        var e = new Date(a[1], 0, 1);
        if (b || !a[13]) {
            b = new Date(a[1], 0, 1, 9, 0);
            if (a[3]) {
                e.setMonth(a[3] - 1);
                b.setMonth(a[3] - 1)
            }
            if (a[5]) {
                e.setDate(a[5]);
                b.setDate(a[5])
            }
            lb(e, b);
            a[7] && e.setHours(a[7]);
            a[8] && e.setMinutes(a[8]);
            a[10] && e.setSeconds(a[10]);
            a[12] && e.setMilliseconds(Number("0." + a[12]) * 1E3);
            lb(e, b)
        } else {
            e.setUTCFullYear(a[1], a[3] ? a[3] - 1 : 0, a[5] || 1);
            e.setUTCHours(a[7] || 0, a[8] || 0, a[10] || 0, a[12] ? Number("0." + a[12]) * 1E3 : 0);
            if (a[14]) {
                b = Number(a[16]) * 60 + (a[18] ? Number(a[18]) : 0);
                b *= a[15] == "-" ? 1 : -1;
                e = new Date(+e + b * 60 * 1E3)
            }
        }
        return e
    }
    function mb(a) {
        if (typeof a == "number") return a * 60;
        if (typeof a == "object") return a.getHours() * 60 + a.getMinutes();
        if (a = a.match(/(\d+)(?::(\d+))?\s*(\w+)?/)) {
            var b = parseInt(a[1], 10);
            if (a[3]) {
                b %= 12;
                if (a[3].toLowerCase().charAt(0) == "p") b += 12
            }
            return b * 60 + (a[2] ? parseInt(a[2],
            10) : 0)
        }
    }
    function Oa(a, b, e) {
        return ib(a, null, b, e)
    }
    function ib(a, b, e, d) {
        d = d || Ya;
        var f = a,
            g = b,
            l, j = e.length,
            t, y, S, Q = "";
        for (l = 0; l < j; l++) {
            t = e.charAt(l);
            if (t == "'") for (y = l + 1; y < j; y++) {
                if (e.charAt(y) == "'") {
                    if (f) {
                        Q += y == l + 1 ? "'" : e.substring(l + 1, y);
                        l = y
                    }
                    break
                }
            } else if (t == "(") for (y = l + 1; y < j; y++) {
                if (e.charAt(y) == ")") {
                    l = Oa(f, e.substring(l + 1, y), d);
                    if (parseInt(l.replace(/\D/, ""), 10)) Q += l;
                    l = y;
                    break
                }
            } else if (t == "[") for (y = l + 1; y < j; y++) {
                if (e.charAt(y) == "]") {
                    t = e.substring(l + 1, y);
                    l = Oa(f, t, d);
                    if (l != Oa(g, t, d)) Q += l;
                    l = y;
                    break
                }
            } else if (t ==
                "{") {
                f = b;
                g = a
            } else if (t == "}") {
                f = a;
                g = b
            } else {
                for (y = j; y > l; y--) if (S = dc[e.substring(l, y)]) {
                    if (f) Q += S(f, d);
                    l = y - 1;
                    break
                }
                if (y == l) if (f) Q += t
            }
        }
        return Q
    }
    function Ua(a) {
        return a.end ? ec(a.end, a.allDay) : ba(N(a.start), 1)
    }
    function ec(a, b) {
        a = N(a);
        return b || a.getHours() || a.getMinutes() ? ba(a, 1) : Ka(a)
    }
    function fc(a, b) {
        return (b.msLength - a.msLength) * 100 + (a.event.start - b.event.start)
    }
    function Cb(a, b) {
        return a.end > b.start && a.start < b.end
    }
    function nb(a, b, e, d) {
        var f = [],
            g, l = a.length,
            j, t, y, S, Q;
        for (g = 0; g < l; g++) {
            j = a[g];
            t = j.start;
            y = b[g];
            if (y > e && t < d) {
                if (t < e) {
                    t = N(e);
                    S = false
                } else {
                    t = t;
                    S = true
                }
                if (y > d) {
                    y = N(d);
                    Q = false
                } else {
                    y = y;
                    Q = true
                }
                f.push({
                    event: j,
                    start: t,
                    end: y,
                    isStart: S,
                    isEnd: Q,
                    msLength: y - t
                })
            }
        }
        return f.sort(fc)
    }
    function ob(a) {
        var b = [],
            e, d = a.length,
            f, g, l, j;
        for (e = 0; e < d; e++) {
            f = a[e];
            for (g = 0;;) {
                l = false;
                if (b[g]) for (j = 0; j < b[g].length; j++) if (Cb(b[g][j], f)) {
                    l = true;
                    break
                }
                if (l) g++;
                else break
            }
            if (b[g]) b[g].push(f);
            else b[g] = [f]
        }
        return b
    }
    function Db(a, b, e) {
        a.unbind("mouseover").mouseover(function (d) {
            for (var f = d.target, g; f != this;) {
                g = f;
                f = f.parentNode
            }
            if ((f = g._fci) !== ma) {
                g._fci = ma;
                g = b[f];
                e(g.event, g.element, g);
                m(d.target).trigger(d)
            }
            d.stopPropagation()
        })
    }
    function Va(a, b, e) {
        for (var d = 0, f; d < a.length; d++) {
            f = m(a[d]);
            f.width(Math.max(0, b - pb(f, e)))
        }
    }
    function Eb(a, b, e) {
        for (var d = 0, f; d < a.length; d++) {
            f = m(a[d]);
            f.height(Math.max(0, b - Sa(f, e)))
        }
    }
    function pb(a, b) {
        return gc(a) + hc(a) + (b ? ic(a) : 0)
    }
    function gc(a) {
        return (parseFloat(m.css(a[0], "paddingLeft", true)) || 0) + (parseFloat(m.css(a[0], "paddingRight", true)) || 0)
    }
    function ic(a) {
        return (parseFloat(m.css(a[0], "marginLeft",
        true)) || 0) + (parseFloat(m.css(a[0], "marginRight", true)) || 0)
    }
    function hc(a) {
        return (parseFloat(m.css(a[0], "borderLeftWidth", true)) || 0) + (parseFloat(m.css(a[0], "borderRightWidth", true)) || 0)
    }
    function Sa(a, b) {
        return jc(a) + kc(a) + (b ? Fb(a) : 0)
    }
    function jc(a) {
        return (parseFloat(m.css(a[0], "paddingTop", true)) || 0) + (parseFloat(m.css(a[0], "paddingBottom", true)) || 0)
    }
    function Fb(a) {
        return (parseFloat(m.css(a[0], "marginTop", true)) || 0) + (parseFloat(m.css(a[0], "marginBottom", true)) || 0)
    }
    function kc(a) {
        return (parseFloat(m.css(a[0],
            "borderTopWidth", true)) || 0) + (parseFloat(m.css(a[0], "borderBottomWidth", true)) || 0)
    }
    function Za(a, b) {
        b = typeof b == "number" ? b + "px" : b;
        a.each(function (e, d) {
            d.style.cssText += ";min-height:" + b + ";_height:" + b
        })
    }
    function xb() {}
    function Gb(a, b) {
        return a - b
    }
    function Hb(a) {
        return Math.max.apply(Math, a)
    }
    function Pa(a) {
        return (a < 10 ? "0" : "") + a
    }
    function jb(a, b) {
        if (a[b] !== ma) return a[b];
        b = b.split(/(?=[A-Z])/);
        for (var e = b.length - 1, d; e >= 0; e--) {
            d = a[b[e].toLowerCase()];
            if (d !== ma) return d
        }
        return a[""]
    }
    function Qa(a) {
        return a.replace(/&/g,
            "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&#039;").replace(/"/g, "&quot;").replace(/\n/g, "<br />")
    }
    function Ib(a) {
        return a.id + "/" + a.className + "/" + a.style.cssText.replace(/(^|;)\s*(top|left|width|height)\s*:[^;]*/ig, "")
    }
    function qb(a) {
        a.attr("unselectable", "on").css("MozUserSelect", "none").bind("selectstart.ui", function () {
            return false
        })
    }
    function ab(a) {
        a.children().removeClass("fc-first fc-last").filter(":first-child").addClass("fc-first").end().filter(":last-child").addClass("fc-last")
    }

    function rb(a, b) {
        a.each(function (e, d) {
            d.className = d.className.replace(/^fc-\w*/, "fc-" + lc[b.getDay()])
        })
    }
    function Jb(a, b) {
        var e = a.source || {}, d = a.color,
            f = e.color,
            g = b("eventColor"),
            l = a.backgroundColor || d || e.backgroundColor || f || b("eventBackgroundColor") || g;
        d = a.borderColor || d || e.borderColor || f || b("eventBorderColor") || g;
        a = a.textColor || e.textColor || b("eventTextColor");
        b = [];
        l && b.push("background-color:" + l);
        d && b.push("border-color:" + d);
        a && b.push("color:" + a);
        return b.join(";")
    }
    function $a(a, b, e) {
        if (m.isFunction(a)) a = [a];
        if (a) {
            var d, f;
            for (d = 0; d < a.length; d++) f = a[d].apply(b, e) || f;
            return f
        }
    }
    function Ta() {
        for (var a = 0; a < arguments.length; a++) if (arguments[a] !== ma) return arguments[a]
    }
    function mc(a, b) {
        function e(j, t) {
            if (t) {
                hb(j, t);
                j.setDate(1)
            }
            j = N(j, true);
            j.setDate(1);
            t = hb(N(j), 1);
            var y = N(j),
                S = N(t),
                Q = f("firstDay"),
                q = f("weekends") ? 0 : 1;
            if (q) {
                Fa(y);
                Fa(S, -1, true)
            }
            ba(y, -((y.getDay() - Math.max(Q, q) + 7) % 7));
            ba(S, (7 - S.getDay() + Math.max(Q, q)) % 7);
            Q = Math.round((S - y) / (Ab * 7));
            if (f("weekMode") == "fixed") {
                ba(S, (6 - Q) * 7);
                Q = 6
            }
            d.title = l(j,
            f("titleFormat"));
            d.start = j;
            d.end = t;
            d.visStart = y;
            d.visEnd = S;
            g(6, Q, q ? 5 : 7, true)
        }
        var d = this;
        d.render = e;
        sb.call(d, a, b, "month");
        var f = d.opt,
            g = d.renderBasic,
            l = b.formatDate
    }
    function nc(a, b) {
        function e(j, t) {
            t && ba(j, t * 7);
            j = ba(N(j), -((j.getDay() - f("firstDay") + 7) % 7));
            t = ba(N(j), 7);
            var y = N(j),
                S = N(t),
                Q = f("weekends");
            if (!Q) {
                Fa(y);
                Fa(S, -1, true)
            }
            d.title = l(y, ba(N(S), -1), f("titleFormat"));
            d.start = j;
            d.end = t;
            d.visStart = y;
            d.visEnd = S;
            g(1, 1, Q ? 7 : 5, false)
        }
        var d = this;
        d.render = e;
        sb.call(d, a, b, "basicWeek");
        var f = d.opt,
            g = d.renderBasic,
            l = b.formatDates
    }
    function oc(a, b) {
        function e(j, t) {
            if (t) {
                ba(j, t);
                f("weekends") || Fa(j, t < 0 ? -1 : 1)
            }
            d.title = l(j, f("titleFormat"));
            d.start = d.visStart = N(j, true);
            d.end = d.visEnd = ba(N(d.start), 1);
            g(1, 1, 1, false)
        }
        var d = this;
        d.render = e;
        sb.call(d, a, b, "basicDay");
        var f = d.opt,
            g = d.renderBasic,
            l = b.formatDate
    }
    function sb(a, b, e) {
        function d(w, I, R, V) {
            v = I;
            F = R;
            f();
            (I = !C) ? g(w, V) : z();
            l(I)
        }
        function f() {
            if (k = L("isRTL")) {
                D = -1;
                Z = F - 1
            } else {
                D = 1;
                Z = 0
            }
            ja = L("firstDay");
            ia = L("weekends") ? 0 : 1;
            la = L("theme") ? "ui" : "fc";
            $ = L("columnFormat")
        }
        function g(w,
        I) {
            var R, V = la + "-widget-header",
                ea = la + "-widget-content",
                aa;
            R = "<table class='fc-border-separate' style='width:100%' cellspacing='0'><thead><tr>";
            for (aa = 0; aa < F; aa++) R += "<th class='fc- " + V + "'/>";
            R += "</tr></thead><tbody>";
            for (aa = 0; aa < w; aa++) {
                R += "<tr class='fc-week" + aa + "'>";
                for (V = 0; V < F; V++) R += "<td class='fc- " + ea + " fc-day" + (aa * F + V) + "'><div>" + (I ? "<div class='fc-day-number'/>" : "") + "<div class='fc-day-content'><div style='position:relative'>&nbsp;</div></div></div></td>";
                R += "</tr>"
            }
            R += "</tbody></table>";
            w = m(R).appendTo(a);
            K = w.find("thead");
            i = K.find("th");
            C = w.find("tbody");
            P = C.find("tr");
            E = C.find("td");
            B = E.filter(":first-child");
            n = P.eq(0).find("div.fc-day-content div");
            ab(K.add(K.find("tr")));
            ab(P);
            P.eq(0).addClass("fc-first");
            y(E);
            Y = m("<div style='position:absolute;z-index:8;top:0;left:0'/>").appendTo(a)
        }
        function l(w) {
            var I = w || v == 1,
                R = p.start.getMonth(),
                V = Ka(new Date),
                ea, aa, va;
            I && i.each(function (wa, Ga) {
                ea = m(Ga);
                aa = ca(wa);
                ea.html(ya(aa, $));
                rb(ea, aa)
            });
            E.each(function (wa, Ga) {
                ea = m(Ga);
                aa = ca(wa);
                aa.getMonth() == R ? ea.removeClass("fc-other-month") : ea.addClass("fc-other-month"); + aa == +V ? ea.addClass(la + "-state-highlight fc-today") : ea.removeClass(la + "-state-highlight fc-today");
                ea.find("div.fc-day-number").text(aa.getDate());
                I && rb(ea, aa)
            });
            P.each(function (wa, Ga) {
                va = m(Ga);
                if (wa < v) {
                    va.show();
                    wa == v - 1 ? va.addClass("fc-last") : va.removeClass("fc-last")
                } else va.hide()
            })
        }
        function j(w) {
            o = w;
            w = o - K.height();
            var I, R, V;
            if (L("weekMode") == "variable") I = R = Math.floor(w / (v == 1 ? 2 : 6));
            else {
                I = Math.floor(w / v);
                R = w - I * (v - 1)
            }
            B.each(function (ea,
            aa) {
                if (ea < v) {
                    V = m(aa);
                    Za(V.find("> div"), (ea == v - 1 ? R : I) - Sa(V))
                }
            })
        }
        function t(w) {
            W = w;
            M.clear();
            s = Math.floor(W / F);
            Va(i.slice(0, -1), s)
        }
        function y(w) {
            w.click(S).mousedown(X)
        }
        function S(w) {
            if (!L("selectable")) {
                var I = parseInt(this.className.match(/fc\-day(\d+)/)[1]);
                I = ca(I);
                c("dayClick", this, I, true, w)
            }
        }
        function Q(w, I, R) {
            R && r.build();
            R = N(p.visStart);
            for (var V = ba(N(R), F), ea = 0; ea < v; ea++) {
                var aa = new Date(Math.max(R, w)),
                    va = new Date(Math.min(V, I));
                if (aa < va) {
                    var wa;
                    if (k) {
                        wa = Ca(va, R) * D + Z + 1;
                        aa = Ca(aa, R) * D + Z + 1
                    } else {
                        wa = Ca(aa, R);
                        aa = Ca(va, R)
                    }
                    y(q(ea, wa, ea, aa - 1))
                }
                ba(R, 7);
                ba(V, 7)
            }
        }
        function q(w, I, R, V) {
            w = r.rect(w, I, R, V, a);
            return H(w, a)
        }
        function u(w) {
            return N(w)
        }
        function fa(w, I) {
            Q(w, ba(N(I), 1), true)
        }
        function oa() {
            T()
        }
        function ga(w, I, R) {
            var V = ua(w);
            c("dayClick", E[V.row * F + V.col], w, I, R)
        }
        function ra(w, I) {
            J.start(function (R) {
                T();
                R && q(R.row, R.col, R.row, R.col)
            }, I)
        }
        function sa(w, I, R) {
            var V = J.stop();
            T();
            if (V) {
                V = pa(V);
                c("drop", w, V, true, I, R)
            }
        }
        function ha(w) {
            return N(w.start)
        }
        function da(w) {
            return M.left(w)
        }
        function na(w) {
            return M.right(w)
        }

        function ua(w) {
            return {
                row: Math.floor(Ca(w, p.visStart) / 7),
                col: ka(w.getDay())
            }
        }
        function pa(w) {
            return U(w.row, w.col)
        }
        function U(w, I) {
            return ba(N(p.visStart), w * 7 + I * D + Z)
        }
        function ca(w) {
            return U(Math.floor(w / F), w % F)
        }
        function ka(w) {
            return (w - Math.max(ja, ia) + F) % F * D + Z
        }
        function qa(w) {
            return P.eq(w)
        }
        function G() {
            return {
                left: 0,
                right: W
            }
        }
        var p = this;
        p.renderBasic = d;
        p.setHeight = j;
        p.setWidth = t;
        p.renderDayOverlay = Q;
        p.defaultSelectionEnd = u;
        p.renderSelection = fa;
        p.clearSelection = oa;
        p.reportDayClick = ga;
        p.dragStart = ra;
        p.dragStop = sa;
        p.defaultEventEnd = ha;
        p.getHoverListener = function () {
            return J
        };
        p.colContentLeft = da;
        p.colContentRight = na;
        p.dayOfWeekCol = ka;
        p.dateCell = ua;
        p.cellDate = pa;
        p.cellIsAllDay = function () {
            return true
        };
        p.allDayRow = qa;
        p.allDayBounds = G;
        p.getRowCnt = function () {
            return v
        };
        p.getColCnt = function () {
            return F
        };
        p.getColWidth = function () {
            return s
        };
        p.getDaySegmentContainer = function () {
            return Y
        };
        Kb.call(p, a, b, e);
        Lb.call(p);
        Mb.call(p);
        pc.call(p);
        var L = p.opt,
            c = p.trigger,
            z = p.clearEvents,
            H = p.renderOverlay,
            T = p.clearOverlays,
            X = p.daySelectionMousedown,
            ya = b.formatDate,
            K, i, C, P, E, B, n, Y, W, o, s, v, F, r, J, M, k, D, Z, ja, ia, la, $;
        qb(a.addClass("fc-grid"));
        r = new Nb(function (w, I) {
            var R, V, ea;
            i.each(function (aa, va) {
                R = m(va);
                V = R.offset().left;
                if (aa) ea[1] = V;
                ea = [V];
                I[aa] = ea
            });
            ea[1] = V + R.outerWidth();
            P.each(function (aa, va) {
                if (aa < v) {
                    R = m(va);
                    V = R.offset().top;
                    if (aa) ea[1] = V;
                    ea = [V];
                    w[aa] = ea
                }
            });
            ea[1] = V + R.outerHeight()
        });
        J = new Ob(r);
        M = new Pb(function (w) {
            return n.eq(w)
        })
    }
    function pc() {
        function a(U, ca) {
            S(U);
            ua(e(U), ca)
        }
        function b() {
            Q();
            ga().empty()
        }
        function e(U) {
            var ca = da(),
                ka = na(),
                qa = N(g.visStart);
            ka = ba(N(qa), ka);
            var G = m.map(U, Ua),
                p, L, c, z, H, T, X = [];
            for (p = 0; p < ca; p++) {
                L = ob(nb(U, G, qa, ka));
                for (c = 0; c < L.length; c++) {
                    z = L[c];
                    for (H = 0; H < z.length; H++) {
                        T = z[H];
                        T.row = p;
                        T.level = c;
                        X.push(T)
                    }
                }
                ba(qa, 7);
                ba(ka, 7)
            }
            return X
        }
        function d(U, ca, ka) {
            t(U) && f(U, ca);
            ka.isEnd && y(U) && pa(U, ca, ka);
            q(U, ca)
        }
        function f(U, ca) {
            var ka = ra(),
                qa;
            ca.draggable({
                zIndex: 9,
                delay: 50,
                opacity: l("dragOpacity"),
                revertDuration: l("dragRevertDuration"),
                start: function (G, p) {
                    j("eventDragStart", ca, U, G, p);
                    fa(U, ca);
                    ka.start(function (L,
                    c, z, H) {
                        ca.draggable("option", "revert", !L || !z && !H);
                        ha();
                        if (L) {
                            qa = z * 7 + H * (l("isRTL") ? -1 : 1);
                            sa(ba(N(U.start), qa), ba(Ua(U), qa))
                        } else qa = 0
                    }, G, "drag")
                },
                stop: function (G, p) {
                    ka.stop();
                    ha();
                    j("eventDragStop", ca, U, G, p);
                    if (qa) oa(this, U, qa, 0, U.allDay, G, p);
                    else {
                        ca.css("filter", "");
                        u(U, ca)
                    }
                }
            })
        }
        var g = this;
        g.renderEvents = a;
        g.compileDaySegs = e;
        g.clearEvents = b;
        g.bindDaySeg = d;
        Qb.call(g);
        var l = g.opt,
            j = g.trigger,
            t = g.isEventDraggable,
            y = g.isEventResizable,
            S = g.reportEvents,
            Q = g.reportEventClear,
            q = g.eventElementHandlers,
            u = g.showEvents,
            fa = g.hideEvents,
            oa = g.eventDrop,
            ga = g.getDaySegmentContainer,
            ra = g.getHoverListener,
            sa = g.renderDayOverlay,
            ha = g.clearOverlays,
            da = g.getRowCnt,
            na = g.getColCnt,
            ua = g.renderDaySegs,
            pa = g.resizableDayEvent
    }
    function qc(a, b) {
        function e(j, t) {
            t && ba(j, t * 7);
            j = ba(N(j), -((j.getDay() - f("firstDay") + 7) % 7));
            t = ba(N(j), 7);
            var y = N(j),
                S = N(t),
                Q = f("weekends");
            if (!Q) {
                Fa(y);
                Fa(S, -1, true)
            }
            d.title = l(y, ba(N(S), -1), f("titleFormat"));
            d.start = j;
            d.end = t;
            d.visStart = y;
            d.visEnd = S;
            g(Q ? 7 : 5)
        }
        var d = this;
        d.render = e;
        Rb.call(d, a, b, "agendaWeek");
        var f = d.opt,
            g = d.renderAgenda,
            l = b.formatDates
    }
    function rc(a, b) {
        function e(j, t) {
            if (t) {
                ba(j, t);
                f("weekends") || Fa(j, t < 0 ? -1 : 1)
            }
            t = N(j, true);
            var y = ba(N(t), 1);
            d.title = l(j, f("titleFormat"));
            d.start = d.visStart = t;
            d.end = d.visEnd = y;
            g(1)
        }
        var d = this;
        d.render = e;
        Rb.call(d, a, b, "agendaDay");
        var f = d.opt,
            g = d.renderAgenda,
            l = b.formatDate
    }
    function Rb(a, b, e) {
        function d(h) {
            Ba = h;
            f();
            v ? P() : g();
            l()
        }
        function f() {
            Wa = i("theme") ? "ui" : "fc";
            Sb = i("weekends") ? 0 : 1;
            Tb = i("firstDay");
            if (Ub = i("isRTL")) {
                Ha = -1;
                Ia = Ba - 1
            } else {
                Ha = 1;
                Ia = 0
            }
            La = mb(i("minTime"));
            bb = mb(i("maxTime"));
            Vb = i("columnFormat")
        }
        function g() {
            var h = Wa + "-widget-header",
                O = Wa + "-widget-content",
                x, A, ta, za, Da, Ea = i("slotMinutes") % 15 == 0;
            x = "<table style='width:100%' class='fc-agenda-days fc-border-separate' cellspacing='0'><thead><tr><th class='fc-agenda-axis " + h + "'>&nbsp;</th>";
            for (A = 0; A < Ba; A++) x += "<th class='fc- fc-col" + A + " " + h + "'/>";
            x += "<th class='fc-agenda-gutter " + h + "'>&nbsp;</th></tr></thead><tbody><tr><th class='fc-agenda-axis " + h + "'>&nbsp;</th>";
            for (A = 0; A < Ba; A++) x += "<td class='fc- fc-col" + A + " " + O + "'><div><div class='fc-day-content'><div style='position:relative'>&nbsp;</div></div></div></td>";
            x += "<td class='fc-agenda-gutter " + O + "'>&nbsp;</td></tr></tbody></table>";
            v = m(x).appendTo(a);
            F = v.find("thead");
            r = F.find("th").slice(1, -1);
            J = v.find("tbody");
            M = J.find("td").slice(0, -1);
            k = M.find("div.fc-day-content div");
            D = M.eq(0);
            Z = D.find("> div");
            ab(F.add(F.find("tr")));
            ab(J.add(J.find("tr")));
            aa = F.find("th:first");
            va = v.find(".fc-agenda-gutter");
            ja = m("<div style='position:absolute;z-index:2;left:0;width:100%'/>").appendTo(a);
            if (i("allDaySlot")) {
                ia = m("<div style='position:absolute;z-index:8;top:0;left:0'/>").appendTo(ja);
                x = "<table style='width:100%' class='fc-agenda-allday' cellspacing='0'><tr><th class='" + h + " fc-agenda-axis'>" + i("allDayText") + "</th><td><div class='fc-day-content'><div style='position:relative'/></div></td><th class='" + h + " fc-agenda-gutter'>&nbsp;</th></tr></table>";
                la = m(x).appendTo(ja);
                $ = la.find("tr");
                q($.find("td"));
                aa = aa.add(la.find("th:first"));
                va = va.add(la.find("th.fc-agenda-gutter"));
                ja.append("<div class='fc-agenda-divider " + h + "'><div class='fc-agenda-divider-inner'/></div>")
            } else ia = m([]);
            w = m("<div style='position:absolute;width:100%;overflow-x:hidden;overflow-y:auto'/>").appendTo(ja);
            I = m("<div style='position:relative;width:100%;overflow:hidden'/>").appendTo(w);
            R = m("<div style='position:absolute;z-index:8;top:0;left:0'/>").appendTo(I);
            x = "<table class='fc-agenda-slots' style='width:100%' cellspacing='0'><tbody>";
            ta = zb();
            za = xa(N(ta), bb);
            xa(ta, La);
            for (A = tb = 0; ta < za; A++) {
                Da = ta.getMinutes();
                x += "<tr class='fc-slot" + A + " " + (!Da ? "" : "fc-minor") + "'><th class='fc-agenda-axis " + h + "'>" + (!Ea || !Da ? s(ta, i("axisFormat")) : "&nbsp;") + "</th><td class='" + O + "'><div style='position:relative'>&nbsp;</div></td></tr>";
                xa(ta, i("slotMinutes"));
                tb++
            }
            x += "</tbody></table>";
            V = m(x).appendTo(I);
            ea = V.find("div:first");
            u(V.find("td"));
            aa = aa.add(V.find("th:first"))
        }
        function l() {
            var h, O, x, A, ta = Ka(new Date);
            for (h = 0; h < Ba; h++) {
                A = ua(h);
                O = r.eq(h);
                O.html(s(A, Vb));
                x = M.eq(h); + A == +ta ? x.addClass(Wa + "-state-highlight fc-today") : x.removeClass(Wa + "-state-highlight fc-today");
                rb(O.add(x), A)
            }
        }
        function j(h, O) {
            if (h === ma) h = Wb;
            Wb = h;
            ub = {};
            var x = J.position().top,
                A = w.position().top;
            h = Math.min(h - x, V.height() + A + 1);
            Z.height(h - Sa(D));
            ja.css("top", x);
            w.height(h - A - 1);
            Xa = ea.height() + 1;
            O && y()
        }
        function t(h) {
            Ga = h;
            cb.clear();
            Ma = 0;
            Va(aa.width("").each(function (O, x) {
                Ma = Math.max(Ma, m(x).outerWidth())
            }), Ma);
            h = w[0].clientWidth;
            if (vb = w.width() - h) {
                Va(va, vb);
                va.show().prev().removeClass("fc-last")
            } else va.hide().prev().addClass("fc-last");
            db = Math.floor((h - Ma) / Ba);
            Va(r.slice(0, -1), db)
        }
        function y() {
            function h() {
                w.scrollTop(A)
            }
            var O = zb(),
                x = N(O);
            x.setHours(i("firstHour"));
            var A = ca(O, x) + 1;
            h();
            setTimeout(h, 0)
        }
        function S() {
            Xb = w.scrollTop()
        }
        function Q() {
            w.scrollTop(Xb)
        }
        function q(h) {
            h.click(fa).mousedown(W)
        }
        function u(h) {
            h.click(fa).mousedown(H)
        }
        function fa(h) {
            if (!i("selectable")) {
                var O = Math.min(Ba - 1, Math.floor((h.pageX - v.offset().left - Ma) / db)),
                    x = ua(O),
                    A = this.parentNode.className.match(/fc-slot(\d+)/);
                if (A) {
                    A = parseInt(A[1]) * i("slotMinutes");
                    var ta = Math.floor(A / 60);
                    x.setHours(ta);
                    x.setMinutes(A % 60 + La);
                    C("dayClick", M[O], x, false,
                    h)
                } else C("dayClick", M[O], x, true, h)
            }
        }
        function oa(h, O, x) {
            x && Na.build();
            var A = N(K.visStart);
            if (Ub) {
                x = Ca(O, A) * Ha + Ia + 1;
                h = Ca(h, A) * Ha + Ia + 1
            } else {
                x = Ca(h, A);
                h = Ca(O, A)
            }
            x = Math.max(0, x);
            h = Math.min(Ba, h);
            x < h && q(ga(0, x, 0, h - 1))
        }
        function ga(h, O, x, A) {
            h = Na.rect(h, O, x, A, ja);
            return E(h, ja)
        }
        function ra(h, O) {
            for (var x = N(K.visStart), A = ba(N(x), 1), ta = 0; ta < Ba; ta++) {
                var za = new Date(Math.max(x, h)),
                    Da = new Date(Math.min(A, O));
                if (za < Da) {
                    var Ea = ta * Ha + Ia;
                    Ea = Na.rect(0, Ea, 0, Ea, I);
                    za = ca(x, za);
                    Da = ca(x, Da);
                    Ea.top = za;
                    Ea.height = Da - za;
                    u(E(Ea,
                    I))
                }
                ba(x, 1);
                ba(A, 1)
            }
        }
        function sa(h) {
            return cb.left(h)
        }
        function ha(h) {
            return cb.right(h)
        }
        function da(h) {
            return {
                row: Math.floor(Ca(h, K.visStart) / 7),
                col: U(h.getDay())
            }
        }
        function na(h) {
            var O = ua(h.col);
            h = h.row;
            i("allDaySlot") && h--;
            h >= 0 && xa(O, La + h * i("slotMinutes"));
            return O
        }
        function ua(h) {
            return ba(N(K.visStart), h * Ha + Ia)
        }
        function pa(h) {
            return i("allDaySlot") && !h.row
        }
        function U(h) {
            return (h - Math.max(Tb, Sb) + Ba) % Ba * Ha + Ia
        }
        function ca(h, O) {
            h = N(h, true);
            if (O < xa(N(h), La)) return 0;
            if (O >= xa(N(h), bb)) return V.height();
            h = i("slotMinutes");
            O = O.getHours() * 60 + O.getMinutes() - La;
            var x = Math.floor(O / h),
                A = ub[x];
            if (A === ma) A = ub[x] = V.find("tr:eq(" + x + ") td div")[0].offsetTop;
            return Math.max(0, Math.round(A - 1 + Xa * (O % h / h)))
        }
        function ka() {
            return {
                left: Ma,
                right: Ga - vb
            }
        }
        function qa() {
            return $
        }
        function G(h) {
            var O = N(h.start);
            if (h.allDay) return O;
            return xa(O, i("defaultEventMinutes"))
        }
        function p(h, O) {
            if (O) return N(h);
            return xa(N(h), i("slotMinutes"))
        }
        function L(h, O, x) {
            if (x) i("allDaySlot") && oa(h, ba(N(O), 1), true);
            else c(h, O)
        }
        function c(h, O) {
            var x = i("selectHelper");
            Na.build();
            if (x) {
                var A = Ca(h, K.visStart) * Ha + Ia;
                if (A >= 0 && A < Ba) {
                    A = Na.rect(0, A, 0, A, I);
                    var ta = ca(h, h),
                        za = ca(h, O);
                    if (za > ta) {
                        A.top = ta;
                        A.height = za - ta;
                        A.left += 2;
                        A.width -= 5;
                        if (m.isFunction(x)) {
                            if (h = x(h, O)) {
                                A.position = "absolute";
                                A.zIndex = 8;
                                wa = m(h).css(A).appendTo(I)
                            }
                        } else {
                            A.isStart = true;
                            A.isEnd = true;
                            wa = m(o({
                                title: "",
                                start: h,
                                end: O,
                                className: ["fc-select-helper"],
                                editable: false
                            }, A));
                            wa.css("opacity", i("dragOpacity"))
                        }
                        if (wa) {
                            u(wa);
                            I.append(wa);
                            Va(wa, A.width, true);
                            Eb(wa, A.height, true)
                        }
                    }
                }
            } else ra(h,
            O)
        }
        function z() {
            B();
            if (wa) {
                wa.remove();
                wa = null
            }
        }
        function H(h) {
            if (h.which == 1 && i("selectable")) {
                Y(h);
                var O;
                Ra.start(function (x, A) {
                    z();
                    if (x && x.col == A.col && !pa(x)) {
                        A = na(A);
                        x = na(x);
                        O = [A, xa(N(A), i("slotMinutes")), x, xa(N(x), i("slotMinutes"))].sort(Gb);
                        c(O[0], O[3])
                    } else O = null
                }, h);
                m(document).one("mouseup", function (x) {
                    Ra.stop();
                    if (O) {
                        +O[0] == +O[1] && T(O[0], false, x);
                        n(O[0], O[3], false, x)
                    }
                })
            }
        }
        function T(h, O, x) {
            C("dayClick", M[U(h.getDay())], h, O, x)
        }
        function X(h, O) {
            Ra.start(function (x) {
                B();
                if (x) if (pa(x)) ga(x.row,
                x.col, x.row, x.col);
                else {
                    x = na(x);
                    var A = xa(N(x), i("defaultEventMinutes"));
                    ra(x, A)
                }
            }, O)
        }
        function ya(h, O, x) {
            var A = Ra.stop();
            B();
            A && C("drop", h, na(A), pa(A), O, x)
        }
        var K = this;
        K.renderAgenda = d;
        K.setWidth = t;
        K.setHeight = j;
        K.beforeHide = S;
        K.afterShow = Q;
        K.defaultEventEnd = G;
        K.timePosition = ca;
        K.dayOfWeekCol = U;
        K.dateCell = da;
        K.cellDate = na;
        K.cellIsAllDay = pa;
        K.allDayRow = qa;
        K.allDayBounds = ka;
        K.getHoverListener = function () {
            return Ra
        };
        K.colContentLeft = sa;
        K.colContentRight = ha;
        K.getDaySegmentContainer = function () {
            return ia
        };
        K.getSlotSegmentContainer = function () {
            return R
        };
        K.getMinMinute = function () {
            return La
        };
        K.getMaxMinute = function () {
            return bb
        };
        K.getBodyContent = function () {
            return I
        };
        K.getRowCnt = function () {
            return 1
        };
        K.getColCnt = function () {
            return Ba
        };
        K.getColWidth = function () {
            return db
        };
        K.getSlotHeight = function () {
            return Xa
        };
        K.defaultSelectionEnd = p;
        K.renderDayOverlay = oa;
        K.renderSelection = L;
        K.clearSelection = z;
        K.reportDayClick = T;
        K.dragStart = X;
        K.dragStop = ya;
        Kb.call(K, a, b, e);
        Lb.call(K);
        Mb.call(K);
        sc.call(K);
        var i = K.opt,
            C = K.trigger,
            P = K.clearEvents,
            E = K.renderOverlay,
            B = K.clearOverlays,
            n = K.reportSelection,
            Y = K.unselect,
            W = K.daySelectionMousedown,
            o = K.slotSegHtml,
            s = b.formatDate,
            v, F, r, J, M, k, D, Z, ja, ia, la, $, w, I, R, V, ea, aa, va, wa, Ga, Wb, Ma, db, vb, Xa, Xb, Ba, tb, Na, Ra, cb, ub = {}, Wa, Tb, Sb, Ub, Ha, Ia, La, bb, Vb;
        qb(a.addClass("fc-agenda"));
        Na = new Nb(function (h, O) {
            function x(eb) {
                return Math.max(Ea, Math.min(tc, eb))
            }
            var A, ta, za;
            r.each(function (eb, uc) {
                A = m(uc);
                ta = A.offset().left;
                if (eb) za[1] = ta;
                za = [ta];
                O[eb] = za
            });
            za[1] = ta + A.outerWidth();
            if (i("allDaySlot")) {
                A = $;
                ta = A.offset().top;
                h[0] = [ta, ta + A.outerHeight()]
            }
            for (var Da = I.offset().top, Ea = w.offset().top, tc = Ea + w.outerHeight(), fb = 0; fb < tb; fb++) h.push([x(Da + Xa * fb), x(Da + Xa * (fb + 1))])
        });
        Ra = new Ob(Na);
        cb = new Pb(function (h) {
            return k.eq(h)
        })
    }
    function sc() {
        function a(o, s) {
            sa(o);
            var v, F = o.length,
                r = [],
                J = [];
            for (v = 0; v < F; v++) o[v].allDay ? r.push(o[v]) : J.push(o[v]);
            if (u("allDaySlot")) {
                L(e(r), s);
                na()
            }
            g(d(J), s)
        }
        function b() {
            ha();
            ua().empty();
            pa().empty()
        }
        function e(o) {
            o = ob(nb(o, m.map(o, Ua), q.visStart, q.visEnd));
            var s, v = o.length,
                F, r, J, M = [];
            for (s = 0; s < v; s++) {
                F = o[s];
                for (r = 0; r < F.length; r++) {
                    J = F[r];
                    J.row = 0;
                    J.level = s;
                    M.push(J)
                }
            }
            return M
        }
        function d(o) {
            var s = z(),
                v = ka(),
                F = ca(),
                r = xa(N(q.visStart), v),
                J = m.map(o, f),
                M, k, D, Z, ja, ia, la = [];
            for (M = 0; M < s; M++) {
                k = ob(nb(o, J, r, xa(N(r), F - v)));
                vc(k);
                for (D = 0; D < k.length; D++) {
                    Z = k[D];
                    for (ja = 0; ja < Z.length; ja++) {
                        ia = Z[ja];
                        ia.col = M;
                        ia.level = D;
                        la.push(ia)
                    }
                }
                ba(r, 1, true)
            }
            return la
        }
        function f(o) {
            return o.end ? N(o.end) : xa(N(o.start), u("defaultEventMinutes"))
        }
        function g(o, s) {
            var v, F = o.length,
                r, J, M, k, D, Z, ja, ia, la,
                $ = "",
                w, I, R = {}, V = {}, ea = pa(),
                aa;
            v = z();
            if (w = u("isRTL")) {
                I = -1;
                aa = v - 1
            } else {
                I = 1;
                aa = 0
            }
            for (v = 0; v < F; v++) {
                r = o[v];
                J = r.event;
                M = qa(r.start, r.start);
                k = qa(r.start, r.end);
                D = r.col;
                Z = r.level;
                ja = r.forward || 0;
                ia = G(D * I + aa);
                la = p(D * I + aa) - ia;
                la = Math.min(la - 6, la * 0.95);
                D = Z ? la / (Z + ja + 1) : ja ? (la / (ja + 1) - 6) * 2 : la;
                Z = ia + la / (Z + ja + 1) * Z * I + (w ? la - D : 0);
                r.top = M;
                r.left = Z;
                r.outerWidth = D;
                r.outerHeight = k - M;
                $ += l(J, r)
            }
            ea[0].innerHTML = $;
            w = ea.children();
            for (v = 0; v < F; v++) {
                r = o[v];
                J = r.event;
                $ = m(w[v]);
                I = fa("eventRender", J, J, $);
                if (I === false) $.remove();
                else {
                    if (I && I !== true) {
                        $.remove();
                        $ = m(I).css({
                            position: "absolute",
                            top: r.top,
                            left: r.left
                        }).appendTo(ea)
                    }
                    r.element = $;
                    if (J._id === s) t(J, $, r);
                    else $[0]._fci = v;
                    ya(J, $)
                }
            }
            Db(ea, o, t);
            for (v = 0; v < F; v++) {
                r = o[v];
                if ($ = r.element) {
                    J = R[s = r.key = Ib($[0])];
                    r.vsides = J === ma ? (R[s] = Sa($, true)) : J;
                    J = V[s];
                    r.hsides = J === ma ? (V[s] = pb($, true)) : J;
                    s = $.find("div.fc-event-content");
                    if (s.length) r.contentTop = s[0].offsetTop
                }
            }
            for (v = 0; v < F; v++) {
                r = o[v];
                if ($ = r.element) {
                    $[0].style.width = Math.max(0, r.outerWidth - r.hsides) + "px";
                    R = Math.max(0, r.outerHeight - r.vsides);
                    $[0].style.height = R + "px";
                    J = r.event;
                    if (r.contentTop !== ma && R - r.contentTop < 10) {
                        $.find("div.fc-event-time").text(Y(J.start, u("timeFormat")) + " - " + J.title);
                        $.find("div.fc-event-title").remove()
                    }
                    fa("eventAfterRender", J, J, $)
                }
            }
        }
        function l(o, s) {
            var v = "<",
                F = o.url,
                r = Jb(o, u),
                J = r ? " style='" + r + "'" : "",
                M = ["fc-event", "fc-event-skin", "fc-event-vert"];
            oa(o) && M.push("fc-event-draggable linktache");
            s.isStart && M.push("fc-corner-top");
            s.isEnd && M.push("fc-corner-bottom");
            M = M.concat(o.className);
            if (o.source) M = M.concat(o.source.className || []);
            v += F ? "a href='" + Qa(o.url) + "'" : "div";
            v += " class='" + M.join(" ") + "' style='position:absolute;z-index:8;top:" + s.top + "px;left:" + s.left + "px;" + r + "'><div class='fc-event-inner fc-event-skin'" + J + "><div class='fc-event-head fc-event-skin'" + J + "><div class='fc-event-time'>" + Qa(W(o.start, o.end, u("timeFormat"))) + "</div></div><div class='fc-event-content'><div class='fc-event-title'>" + Qa(o.title) + "</div></div><div class='fc-event-bg'></div></div>";
            if (s.isEnd && ga(o)) v += "<div class='ui-resizable-handle ui-resizable-s'>=</div>";
            v += "</" + (F ? "a" : "div") + ">";
            return v
        }
        function j(o, s, v) {
            oa(o) && y(o, s, v.isStart);
            v.isEnd && ga(o) && c(o, s, v);
            da(o, s)
        }
        function t(o, s, v) {
            var F = s.find("div.fc-event-time");
            oa(o) && S(o, s, F);
            v.isEnd && ga(o) && Q(o, s, F);
            da(o, s)
        }
        function y(o, s, v) {
            function F() {
                if (!M) {
                    s.width(r).height("").draggable("option", "grid", null);
                    M = true
                }
            }
            var r, J, M = true,
                k, D = u("isRTL") ? -1 : 1,
                Z = U(),
                ja = H(),
                ia = T(),
                la = ka();
            s.draggable({
                zIndex: 9,
                opacity: u("dragOpacity", "month"),
                revertDuration: u("dragRevertDuration"),
                start: function ($, w) {
                    fa("eventDragStart",
                    s, o, $, w);
                    i(o, s);
                    r = s.width();
                    Z.start(function (I, R, V, ea) {
                        B();
                        if (I) {
                            J = false;
                            k = ea * D;
                            if (I.row) if (v) {
                                if (M) {
                                    s.width(ja - 10);
                                    Eb(s, ia * Math.round((o.end ? (o.end - o.start) / wc : u("defaultEventMinutes")) / u("slotMinutes")));
                                    s.draggable("option", "grid", [ja, 1]);
                                    M = false
                                }
                            } else J = true;
                            else {
                                E(ba(N(o.start), k), ba(Ua(o), k));
                                F()
                            }
                            J = J || M && !k
                        } else {
                            F();
                            J = true
                        }
                        s.draggable("option", "revert", J)
                    }, $, "drag")
                },
                stop: function ($, w) {
                    Z.stop();
                    B();
                    fa("eventDragStop", s, o, $, w);
                    if (J) {
                        F();
                        s.css("filter", "");
                        K(o, s)
                    } else {
                        var I = 0;
                        M || (I = Math.round((s.offset().top - X().offset().top) / ia) * u("slotMinutes") + la - (o.start.getHours() * 60 + o.start.getMinutes()));
                        C(this, o, k, I, M, $, w)
                    }
                }
            })
        }
        function S(o, s, v) {
            function F(I) {
                var R = xa(N(o.start), I),
                    V;
                if (o.end) V = xa(N(o.end), I);
                v.text(W(R, V, u("timeFormat")))
            }
            function r() {
                if (M) {
                    v.css("display", "");
                    s.draggable("option", "grid", [$, w]);
                    M = false
                }
            }
            var J, M = false,
                k, D, Z, ja = u("isRTL") ? -1 : 1,
                ia = U(),
                la = z(),
                $ = H(),
                w = T();
            s.draggable({
                zIndex: 9,
                scroll: false,
                grid: [$, w],
                axis: la == 1 ? "y" : false,
                opacity: u("dragOpacity"),
                revertDuration: u("dragRevertDuration"),
                start: function (I, R) {
                    fa("eventDragStart", s, o, I, R);
                    i(o, s);
                    J = s.position();
                    D = Z = 0;
                    ia.start(function (V, ea, aa, va) {
                        s.draggable("option", "revert", !V);
                        B();
                        if (V) {
                            k = va * ja;
                            if (u("allDaySlot") && !V.row) {
                                if (!M) {
                                    M = true;
                                    v.hide();
                                    s.draggable("option", "grid", null)
                                }
                                E(ba(N(o.start), k), ba(Ua(o), k))
                            } else r()
                        }
                    }, I, "drag")
                },
                drag: function (I, R) {
                    D = Math.round((R.position.top - J.top) / w) * u("slotMinutes");
                    if (D != Z) {
                        M || F(D);
                        Z = D
                    }
                },
                stop: function (I, R) {
                    var V = ia.stop();
                    B();
                    fa("eventDragStop", s, o, I, R);
                    if (V && (k || D || M)) C(this, o, k, M ? 0 : D, M, I, R);
                    else {
                        r();
                        s.css("filter", "");
                        s.css(J);
                        F(0);
                        K(o, s)
                    }
                }
            })
        }
        function Q(o, s, v) {
            var F, r, J = T();
            s.resizable({
                handles: {
                    s: "div.ui-resizable-s"
                },
                grid: J,
                start: function (M, k) {
                    F = r = 0;
                    i(o, s);
                    s.css("z-index", 9);
                    fa("eventResizeStart", this, o, M, k)
                },
                resize: function (M, k) {
                    F = Math.round((Math.max(J, s.height()) - k.originalSize.height) / J);
                    if (F != r) {
                        v.text(W(o.start, !F && !o.end ? null : xa(ra(o), u("slotMinutes") * F), u("timeFormat")));
                        r = F
                    }
                },
                stop: function (M, k) {
                    fa("eventResizeStop", this, o, M, k);
                    if (F) P(this, o, 0, u("slotMinutes") * F, M, k);
                    else {
                        s.css("z-index",
                        8);
                        K(o, s)
                    }
                }
            })
        }
        var q = this;
        q.renderEvents = a;
        q.compileDaySegs = e;
        q.clearEvents = b;
        q.slotSegHtml = l;
        q.bindDaySeg = j;
        Qb.call(q);
        var u = q.opt,
            fa = q.trigger,
            oa = q.isEventDraggable,
            ga = q.isEventResizable,
            ra = q.eventEnd,
            sa = q.reportEvents,
            ha = q.reportEventClear,
            da = q.eventElementHandlers,
            na = q.setHeight,
            ua = q.getDaySegmentContainer,
            pa = q.getSlotSegmentContainer,
            U = q.getHoverListener,
            ca = q.getMaxMinute,
            ka = q.getMinMinute,
            qa = q.timePosition,
            G = q.colContentLeft,
            p = q.colContentRight,
            L = q.renderDaySegs,
            c = q.resizableDayEvent,
            z = q.getColCnt,
            H = q.getColWidth,
            T = q.getSlotHeight,
            X = q.getBodyContent,
            ya = q.reportEventElement,
            K = q.showEvents,
            i = q.hideEvents,
            C = q.eventDrop,
            P = q.eventResize,
            E = q.renderDayOverlay,
            B = q.clearOverlays,
            n = q.calendar,
            Y = n.formatDate,
            W = n.formatDates
    }
    function vc(a) {
        var b, e, d, f, g, l;
        for (b = a.length - 1; b > 0; b--) {
            f = a[b];
            for (e = 0; e < f.length; e++) {
                g = f[e];
                for (d = 0; d < a[b - 1].length; d++) {
                    l = a[b - 1][d];
                    if (Cb(g, l)) l.forward = Math.max(l.forward || 0, (g.forward || 0) + 1)
                }
            }
        }
    }
    function Kb(a, b, e) {
        function d(G, p) {
            G = qa[G];
            if (typeof G == "object") return jb(G, p || e);
            return G
        }
        function f(G, p) {
            return b.trigger.apply(b, [G, p || da].concat(Array.prototype.slice.call(arguments, 2), [da]))
        }
        function g(G) {
            return j(G) && !d("disableDragging")
        }
        function l(G) {
            return j(G) && !d("disableResizing")
        }
        function j(G) {
            return Ta(G.editable, (G.source || {}).editable, d("editable"))
        }
        function t(G) {
            U = {};
            var p, L = G.length,
                c;
            for (p = 0; p < L; p++) {
                c = G[p];
                if (U[c._id]) U[c._id].push(c);
                else U[c._id] = [c]
            }
        }
        function y(G) {
            return G.end ? N(G.end) : na(G)
        }
        function S(G, p) {
            ca.push(p);
            if (ka[G._id]) ka[G._id].push(p);
            else ka[G._id] = [p]
        }
        function Q() {
            ca = [];
            ka = {}
        }
        function q(G, p) {
            p.click(function (L) {
                if (!p.hasClass("ui-draggable-dragging") && !p.hasClass("ui-resizable-resizing")) return f("eventClick", this, G, L)
            }).hover(function (L) {
                f("eventMouseover", this, G, L)
            }, function (L) {
                f("eventMouseout", this, G, L)
            })
        }
        function u(G, p) {
            oa(G, p, "show")
        }
        function fa(G, p) {
            oa(G, p, "hide")
        }
        function oa(G, p, L) {
            G = ka[G._id];
            var c, z = G.length;
            for (c = 0; c < z; c++) if (!p || G[c][0] != p[0]) G[c][L]()
        }
        function ga(G, p, L, c, z, H, T) {
            var X = p.allDay,
                ya = p._id;
            sa(U[ya], L, c, z);
            f("eventDrop",
            G, p, L, c, z, function () {
                sa(U[ya], -L, -c, X);
                pa(ya)
            }, H, T);
            pa(ya)
        }
        function ra(G, p, L, c, z, H) {
            var T = p._id;
            ha(U[T], L, c);
            f("eventResize", G, p, L, c, function () {
                ha(U[T], -L, -c);
                pa(T)
            }, z, H);
            pa(T)
        }
        function sa(G, p, L, c) {
            L = L || 0;
            for (var z, H = G.length, T = 0; T < H; T++) {
                z = G[T];
                if (c !== ma) z.allDay = c;
                xa(ba(z.start, p, true), L);
                if (z.end) z.end = xa(ba(z.end, p, true), L);
                ua(z, qa)
            }
        }
        function ha(G, p, L) {
            L = L || 0;
            for (var c, z = G.length, H = 0; H < z; H++) {
                c = G[H];
                c.end = xa(ba(y(c), p, true), L);
                ua(c, qa)
            }
        }
        var da = this;
        da.element = a;
        da.calendar = b;
        da.name = e;
        da.opt = d;
        da.trigger = f;
        da.isEventDraggable = g;
        da.isEventResizable = l;
        da.reportEvents = t;
        da.eventEnd = y;
        da.reportEventElement = S;
        da.reportEventClear = Q;
        da.eventElementHandlers = q;
        da.showEvents = u;
        da.hideEvents = fa;
        da.eventDrop = ga;
        da.eventResize = ra;
        var na = da.defaultEventEnd,
            ua = b.normalizeEvent,
            pa = b.reportEventChange,
            U = {}, ca = [],
            ka = {}, qa = b.options
    }
    function Qb() {
        function a(i, C) {
            var P = z(),
                E = pa(),
                B = U(),
                n = 0,
                Y, W, o = i.length,
                s, v;
            P[0].innerHTML = e(i);
            d(i, P.children());
            f(i);
            g(i, P, C);
            l(i);
            j(i);
            t(i);
            C = y();
            for (P = 0; P < E; P++) {
                Y = [];
                for (W = 0; W < B; W++) Y[W] = 0;
                for (; n < o && (s = i[n]).row == P;) {
                    W = Hb(Y.slice(s.startCol, s.endCol));
                    s.top = W;
                    W += s.outerHeight;
                    for (v = s.startCol; v < s.endCol; v++) Y[v] = W;
                    n++
                }
                C[P].height(Hb(Y))
            }
            Q(i, S(C))
        }
        function b(i, C, P) {
            var E = m("<div/>"),
                B = z(),
                n = i.length,
                Y;
            E[0].innerHTML = e(i);
            E = E.children();
            B.append(E);
            d(i, E);
            l(i);
            j(i);
            t(i);
            Q(i, S(y()));
            E = [];
            for (B = 0; B < n; B++) if (Y = i[B].element) {
                i[B].row === C && Y.css("top", P);
                E.push(Y[0])
            }
            return m(E)
        }
        function e(i) {
            var C = fa("isRTL"),
                P, E = i.length,
                B, n, Y, W;
            P = ka();
            var o = P.left,
                s = P.right,
                v, F, r, J, M, k =
                    "";
            for (P = 0; P < E; P++) {
                B = i[P];
                n = B.event;
                W = ["fc-event", "fc-event-skin", "fc-event-hori"];
                ga(n) && W.push("fc-event-draggable linktache");
                if (C) {
                    B.isStart && W.push("fc-corner-right");
                    B.isEnd && W.push("fc-corner-left");
                    v = p(B.end.getDay() - 1);
                    F = p(B.start.getDay());
                    r = B.isEnd ? qa(v) : o;
                    J = B.isStart ? G(F) : s
                } else {
                    B.isStart && W.push("fc-corner-left");
                    B.isEnd && W.push("fc-corner-right");
                    v = p(B.start.getDay());
                    F = p(B.end.getDay() - 1);
                    r = B.isStart ? qa(v) : o;
                    J = B.isEnd ? G(F) : s
                }
                W = W.concat(n.className);
                if (n.source) W = W.concat(n.source.className || []);
                Y = n.url;
                M = Jb(n, fa);
                k += Y ? "<a href='" + Qa(Y) + "'" : "<div";
                k += " class='" + W.join(" ") + "' style='position:absolute;z-index:8;left:" + r + "px;" + M + "'><div class='fc-event-inner fc-event-skin'" + (M ? " style='" + M + "'" : "") + ">";
                if (!n.allDay && B.isStart) k += "<span class='fc-event-time'>" + Qa(T(n.start, n.end, fa("timeFormat"))) + "</span>";
                k += "<span class='fc-event-title'>" + Qa(n.title) + "</span></div>";
                if (B.isEnd && ra(n)) k += "<div class='ui-resizable-handle ui-resizable-" + (C ? "w" : "e") + "'>&nbsp;&nbsp;&nbsp;</div>";
                k += "</" + (Y ?
                    "a" : "div") + ">";
                B.left = r;
                B.outerWidth = J - r;
                B.startCol = v;
                B.endCol = F + 1
            }
            return k
        }
        function d(i, C) {
            var P, E = i.length,
                B, n, Y;
            for (P = 0; P < E; P++) {
                B = i[P];
                n = B.event;
                Y = m(C[P]);
                n = oa("eventRender", n, n, Y);
                if (n === false) Y.remove();
                else {
                    if (n && n !== true) {
                        n = m(n).css({
                            position: "absolute",
                            left: B.left
                        });
                        Y.replaceWith(n);
                        Y = n
                    }
                    B.element = Y
                }
            }
        }
        function f(i) {
            var C, P = i.length,
                E, B;
            for (C = 0; C < P; C++) {
                E = i[C];
                (B = E.element) && ha(E.event, B)
            }
        }
        function g(i, C, P) {
            var E, B = i.length,
                n, Y, W;
            for (E = 0; E < B; E++) {
                n = i[E];
                if (Y = n.element) {
                    W = n.event;
                    if (W._id === P) H(W, Y, n);
                    else Y[0]._fci = E
                }
            }
            Db(C, i, H)
        }
        function l(i) {
            var C, P = i.length,
                E, B, n, Y, W = {};
            for (C = 0; C < P; C++) {
                E = i[C];
                if (B = E.element) {
                    n = E.key = Ib(B[0]);
                    Y = W[n];
                    if (Y === ma) Y = W[n] = pb(B, true);
                    E.hsides = Y
                }
            }
        }
        function j(i) {
            var C, P = i.length,
                E, B;
            for (C = 0; C < P; C++) {
                E = i[C];
                if (B = E.element) B[0].style.width = Math.max(0, E.outerWidth - E.hsides) + "px"
            }
        }
        function t(i) {
            var C, P = i.length,
                E, B, n, Y, W = {};
            for (C = 0; C < P; C++) {
                E = i[C];
                if (B = E.element) {
                    n = E.key;
                    Y = W[n];
                    if (Y === ma) Y = W[n] = Fb(B);
                    E.outerHeight = B[0].offsetHeight + Y
                }
            }
        }
        function y() {
            var i, C = pa(),
                P = [];
            for (i = 0; i < C; i++) P[i] = ca(i).find("td:first div.fc-day-content > div");
            return P
        }
        function S(i) {
            var C, P = i.length,
                E = [];
            for (C = 0; C < P; C++) E[C] = i[C][0].offsetTop;
            return E
        }
        function Q(i, C) {
            var P, E = i.length,
                B, n;
            for (P = 0; P < E; P++) {
                B = i[P];
                if (n = B.element) {
                    n[0].style.top = C[B.row] + (B.top || 0) + "px";
                    B = B.event;
                    oa("eventAfterRender", B, B, n)
                }
            }
        }
        function q(i, C, P) {
            var E = fa("isRTL"),
                B = E ? "w" : "e",
                n = C.find("div.ui-resizable-" + B),
                Y = false;
            qb(C);
            C.mousedown(function (W) {
                W.preventDefault()
            }).click(function (W) {
                if (Y) {
                    W.preventDefault();
                    W.stopImmediatePropagation()
                }
            });
            n.mousedown(function (W) {
                function o(ia) {
                    oa("eventResizeStop", this, i, ia);
                    m("body").css("cursor", "");
                    s.stop();
                    ya();
                    k && ua(this, i, k, 0, ia);
                    setTimeout(function () {
                        Y = false
                    }, 0)
                }
                if (W.which == 1) {
                    Y = true;
                    var s = u.getHoverListener(),
                        v = pa(),
                        F = U(),
                        r = E ? -1 : 1,
                        J = E ? F - 1 : 0,
                        M = C.css("top"),
                        k, D, Z = m.extend({}, i),
                        ja = L(i.start);
                    K();
                    m("body").css("cursor", B + "-resize").one("mouseup", o);
                    oa("eventResizeStart", this, i, W);
                    s.start(function (ia, la) {
                        if (ia) {
                            var $ = Math.max(ja.row, ia.row);
                            ia = ia.col;
                            if (v == 1) $ = 0;
                            if ($ == ja.row) ia = E ? Math.min(ja.col, ia) : Math.max(ja.col, ia);
                            k = $ * 7 + ia * r + J - (la.row * 7 + la.col * r + J);
                            la = ba(sa(i), k, true);
                            if (k) {
                                Z.end = la;
                                $ = D;
                                D = b(c([Z]), P.row, M);
                                D.find("*").css("cursor", B + "-resize");
                                $ && $.remove();
                                na(i)
                            } else if (D) {
                                da(i);
                                D.remove();
                                D = null
                            }
                            ya();
                            X(i.start, ba(N(la), 1))
                        }
                    }, W)
                }
            })
        }
        var u = this;
        u.renderDaySegs = a;
        u.resizableDayEvent = q;
        var fa = u.opt,
            oa = u.trigger,
            ga = u.isEventDraggable,
            ra = u.isEventResizable,
            sa = u.eventEnd,
            ha = u.reportEventElement,
            da = u.showEvents,
            na = u.hideEvents,
            ua = u.eventResize,
            pa = u.getRowCnt,
            U = u.getColCnt,
            ca = u.allDayRow,
            ka = u.allDayBounds,
            qa = u.colContentLeft,
            G = u.colContentRight,
            p = u.dayOfWeekCol,
            L = u.dateCell,
            c = u.compileDaySegs,
            z = u.getDaySegmentContainer,
            H = u.bindDaySeg,
            T = u.calendar.formatDates,
            X = u.renderDayOverlay,
            ya = u.clearOverlays,
            K = u.clearSelection
    }
    function Mb() {
        function a(Q, q, u) {
            b();
            q || (q = j(Q, u));
            t(Q, q, u);
            e(Q, q, u)
        }
        function b(Q) {
            if (S) {
                S = false;
                y();
                l("unselect", null, Q)
            }
        }
        function e(Q, q, u, fa) {
            S = true;
            l("select", null, Q, q, u, fa)
        }
        function d(Q) {
            var q = f.cellDate,
                u = f.cellIsAllDay,
                fa = f.getHoverListener(),
                oa = f.reportDayClick;
            if (Q.which == 1 && g("selectable")) {
                b(Q);
                var ga;
                fa.start(function (ra, sa) {
                    y();
                    if (ra && u(ra)) {
                        ga = [q(sa), q(ra)].sort(Gb);
                        t(ga[0], ga[1], true)
                    } else ga = null
                }, Q);
                m(document).one("mouseup", function (ra) {
                    fa.stop();
                    if (ga) {
                        +ga[0] == +ga[1] && oa(ga[0], true, ra);
                        e(ga[0], ga[1], true, ra)
                    }
                })
            }
        }
        var f = this;
        f.select = a;
        f.unselect = b;
        f.reportSelection = e;
        f.daySelectionMousedown = d;
        var g = f.opt,
            l = f.trigger,
            j = f.defaultSelectionEnd,
            t = f.renderSelection,
            y = f.clearSelection,
            S = false;
        g("selectable") && g("unselectAuto") && m(document).mousedown(function (Q) {
            var q = g("unselectCancel");
            if (q) if (m(Q.target).parents(q).length) return;
            b(Q)
        })
    }
    function Lb() {
        function a(g, l) {
            var j = f.shift();
            j || (j = m("<div class='fc-cell-overlay' style='position:absolute;z-index:3'/>"));
            j[0].parentNode != l[0] && j.appendTo(l);
            d.push(j.css(g).show());
            return j
        }
        function b() {
            for (var g; g = d.shift();) f.push(g.hide().unbind())
        }
        var e = this;
        e.renderOverlay = a;
        e.clearOverlays = b;
        var d = [],
            f = []
    }
    function Nb(a) {
        var b = this,
            e, d;
        b.build = function () {
            e = [];
            d = [];
            a(e, d)
        };
        b.cell = function (f, g) {
            var l = e.length,
                j = d.length,
                t, y = -1,
                S = -1;
            for (t = 0; t < l; t++) if (g >= e[t][0] && g < e[t][1]) {
                y = t;
                break
            }
            for (t = 0; t < j; t++) if (f >= d[t][0] && f < d[t][1]) {
                S = t;
                break
            }
            return y >= 0 && S >= 0 ? {
                row: y,
                col: S
            } : null
        };
        b.rect = function (f, g, l, j, t) {
            t = t.offset();
            return {
                top: e[f][0] - t.top,
                left: d[g][0] - t.left,
                width: d[j][1] - d[g][0],
                height: e[l][1] - e[f][0]
            }
        }
    }
    function Ob(a) {
        function b(j) {
            xc(j);
            j = a.cell(j.pageX, j.pageY);
            if (!j != !l || j && (j.row != l.row || j.col != l.col)) {
                if (j) {
                    g || (g = j);
                    f(j, g, j.row - g.row, j.col - g.col)
                } else f(j, g);
                l = j
            }
        }
        var e = this,
            d, f, g, l;
        e.start = function (j, t, y) {
            f = j;
            g = l = null;
            a.build();
            b(t);
            d = y || "mousemove";
            m(document).bind(d, b)
        };
        e.stop = function () {
            m(document).unbind(d, b);
            return l
        }
    }
    function xc(a) {
        if (a.pageX === ma) {
            a.pageX = a.originalEvent.pageX;
            a.pageY = a.originalEvent.pageY
        }
    }
    function Pb(a) {
        function b(l) {
            return d[l] = d[l] || a(l)
        }
        var e = this,
            d = {}, f = {}, g = {};
        e.left = function (l) {
            return f[l] = f[l] === ma ? b(l).position().left : f[l]
        };
        e.right = function (l) {
            return g[l] = g[l] === ma ? e.left(l) + b(l).width() : g[l]
        };
        e.clear = function () {
            d = {};
            f = {};
            g = {}
        }
    }
    var Ya = {
        defaultView: "month",
        aspectRatio: 1.35,
        header: {
            left: "title",
            center: "",
            right: "today prev,next"
        },
        weekends: true,
        allDayDefault: true,
        ignoreTimezone: true,
        lazyFetching: true,
        startParam: "start",
        endParam: "end",
        titleFormat: {
            month: "MMMM yyyy",
            week: "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}",
            day: "dddd, MMM d, yyyy"
        },
        columnFormat: {
            month: "ddd",
            week: "ddd M/d",
            day: "dddd M/d"
        },
        timeFormat: {
            "": "h(:mm)t"
        },
        isRTL: false,
        firstDay: 0,
        monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
        monthNamesShort: ["Jan",
            "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        dayNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        dayNamesShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
        buttonText: {
            prev: "&nbsp;&#9668;&nbsp;",
            next: "&nbsp;&#9658;&nbsp;",
            prevYear: "&nbsp;&lt;&lt;&nbsp;",
            nextYear: "&nbsp;&gt;&gt;&nbsp;",
            today: "today",
            month: "month",
            week: "week",
            day: "day"
        },
        theme: false,
        buttonIcons: {
            prev: "circle-triangle-w",
            next: "circle-triangle-e"
        },
        unselectAuto: true,
        dropAccept: "*"
    }, yc = {
        header: {
            left: "next,prev today",
            center: "",
            right: "title"
        },
        buttonText: {
            prev: "&nbsp;&#9658;&nbsp;",
            next: "&nbsp;&#9668;&nbsp;",
            prevYear: "&nbsp;&gt;&gt;&nbsp;",
            nextYear: "&nbsp;&lt;&lt;&nbsp;"
        },
        buttonIcons: {
            prev: "circle-triangle-e",
            next: "circle-triangle-w"
        }
    }, Aa = m.fullCalendar = {
        version: "1.5.4"
    }, Ja = Aa.views = {};
    m.fn.fullCalendar = function (a) {
        if (typeof a == "string") {
            var b = Array.prototype.slice.call(arguments, 1),
                e;
            this.each(function () {
                var f = m.data(this, "fullCalendar");
                if (f && m.isFunction(f[a])) {
                    f = f[a].apply(f,
                    b);
                    if (e === ma) e = f;
                    a == "destroy" && m.removeData(this, "fullCalendar")
                }
            });
            if (e !== ma) return e;
            return this
        }
        var d = a.eventSources || [];
        delete a.eventSources;
        if (a.events) {
            d.push(a.events);
            delete a.events
        }
        a = m.extend(true, {}, Ya, a.isRTL || a.isRTL === ma && Ya.isRTL ? yc : {}, a);
        this.each(function (f, g) {
            f = m(g);
            g = new Yb(f, a, d);
            f.data("fullCalendar", g);
            g.render()
        });
        return this
    };
    Aa.sourceNormalizers = [];
    Aa.sourceFetchers = [];
    var ac = {
        dataType: "json",
        cache: false
    }, bc = 1;
    Aa.addDays = ba;
    Aa.cloneDate = N;
    Aa.parseDate = kb;
    Aa.parseISO8601 = Bb;
    Aa.parseTime = mb;
    Aa.formatDate = Oa;
    Aa.formatDates = ib;
    var lc = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"],
        Ab = 864E5,
        cc = 36E5,
        wc = 6E4,
        dc = {
            s: function (a) {
                return a.getSeconds()
            },
            ss: function (a) {
                return Pa(a.getSeconds())
            },
            m: function (a) {
                return a.getMinutes()
            },
            mm: function (a) {
                return Pa(a.getMinutes())
            },
            h: function (a) {
                return a.getHours() % 12 || 12
            },
            hh: function (a) {
                return Pa(a.getHours() % 12 || 12)
            },
            H: function (a) {
                return a.getHours()
            },
            HH: function (a) {
                return Pa(a.getHours())
            },
            d: function (a) {
                return a.getDate()
            },
            dd: function (a) {
                return Pa(a.getDate())
            },
            ddd: function (a, b) {
                return b.dayNamesShort[a.getDay()]
            },
            dddd: function (a, b) {
                return b.dayNames[a.getDay()]
            },
            M: function (a) {
                return a.getMonth() + 1
            },
            MM: function (a) {
                return Pa(a.getMonth() + 1)
            },
            MMM: function (a, b) {
                return b.monthNamesShort[a.getMonth()]
            },
            MMMM: function (a, b) {
                return b.monthNames[a.getMonth()]
            },
            yy: function (a) {
                return (a.getFullYear() + "").substring(2)
            },
            yyyy: function (a) {
                return a.getFullYear()
            },
            t: function (a) {
                return a.getHours() < 12 ? "a" : "p"
            },
            tt: function (a) {
                return a.getHours() < 12 ? "am" : "pm"
            },
            T: function (a) {
                return a.getHours() < 12 ? "A" : "P"
            },
            TT: function (a) {
                return a.getHours() < 12 ? "AM" : "PM"
            },
            u: function (a) {
                return Oa(a, "yyyy-MM-dd'T'HH:mm:ss'Z'")
            },
            S: function (a) {
                a = a.getDate();
                if (a > 10 && a < 20) return "th";
                return ["st", "nd", "rd"][a % 10 - 1] || "th"
            }
        };
    Aa.applyAll = $a;
    Ja.month = mc;
    Ja.basicWeek = nc;
    Ja.basicDay = oc;
    wb({
        weekMode: "fixed"
    });
    Ja.agendaWeek = qc;
    Ja.agendaDay = rc;
    wb({
        allDaySlot: true,
        allDayText: "all-day",
        firstHour: 6,
        slotMinutes: 30,
        defaultEventMinutes: 120,
        axisFormat: "h(:mm)tt",
        timeFormat: {
            agenda: "h:mm{ - h:mm}"
        },
        dragOpacity: {
            agenda: 0.5
        },
        minTime: 0,
        maxTime: 24
    })
})(jQuery);